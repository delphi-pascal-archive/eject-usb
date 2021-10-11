unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms,
  Dialogs, StdCtrls, ShlObj, Controls, CheckLst, ExtCtrls;

type
  TRetirerUSB = class(TForm)
    Eject: TButton;
    ListeUSB: TCheckListBox;
    Label1: TLabel;
    procedure EjectClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
    Procedure EtatConnectionUSB(var Msg: TMessage);Message $0219;
  public
    { Déclarations publiques }
  end;

var
  RetirerUSB               : TRetirerUSB;
  LettreVolume,Volume : String;
implementation

{$R *.dfm}

Procedure TRetirerUSB.EtatConnectionUSB(var Msg: TMessage);
//Vient de Dbt.h
Type
  DEV_BROADCAST_HDR     = ^PDEV_BROADCAST_HDR;
    PDEV_BROADCAST_HDR  = packed record
      dbch_size         : DWORD;
      dbch_devicetype   : DWORD;
      dbch_reserved     : DWORD;
  end;

  DEV_BROADCAST_VOLUME    = ^PDEV_BROADCAST_VOLUME;
    PDEV_BROADCAST_VOLUME = packed record
      dbcv_size           : DWORD;
      dbcv_devicetype     : DWORD;
      dbcv_reserved       : DWORD;
      dbcv_unitmask       : DWORD;
      dbcv_flags          : WORD;
  end;
var
  C:Integer;
begin
  //Déconnexion physique
  if Msg.wParam = $8004 then
    if DEV_BROADCAST_HDR(Msg.LParam)^.dbch_devicetype=2 then
      if DEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_flags=0 then
      begin
        Str(Ln(DEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_unitmask)/Ln(2)+Ord('A'):2:0,LettreVolume);
        LettreVolume:=Char(StrToInt(LettreVolume));
        For c:=0 to ListeUSB.Count-1 do
        begin
          //Suppression du volume de la liste
          Volume:=ListeUSB.Items.Strings[c];
          if Volume[1]=LettreVolume then
          begin
            ListeUSB.Items.Delete(c);
            Break;
          end;
        end;
      end;
  //Connexion physique
  if Msg.wParam = $8000 then
    if DEV_BROADCAST_HDR(Msg.LParam)^.dbch_devicetype=2 then
      if DEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_flags=0 then
      begin
        //Ajout du nouveau volume dans la liste
        Str(Ln(DEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_unitmask)/Ln(2)+Ord('A'):2:0,LettreVolume);
        LettreVolume:=Char(StrToInt(LettreVolume));
        ListeUSB.Items.Add(LettreVolume+':\ Connected');
      end;
end;

Function EjectUSB(LettreLecteur:String;Tempo:Integer=0;NbdeFois:Integer=1):Boolean;
const
  //Les paramètres suivants viennent de WinIoCtl.h
  FSCTL_LOCK_VOLUME           = ($00000009 shl 16) or ($0000 shl 14) or (00006 shl 2) or 0;
  FSCTL_DISMOUNT_VOLUME       = ($00000009 shl 16) or ($0000 shl 14) or (00008 shl 2) or 0;
  IOCTL_STORAGE_MEDIA_REMOVAL = ($0000002d shl 16) or ($0001 shl 14) or ($0201 shl 2) or 0;
  IOCTL_STORAGE_EJECT_MEDIA   = ($0000002d shl 16) or ($0001 shl 14) or ($0202 shl 2) or 0;
  FSCTL_UNLOCK_VOLUME         = ($00000009 shl 16) or ($0000 shl 14) or (00007 shl 2) or 0;
Type
  TPREVENT_MEDIA_REMOVAL  = record
      PreventMediaRemoval : ByteBool;
end;
var
  HandleVolume        : THandle;
  FormatLettreLecteur : String;
  lpBytesReturned     : DWORD;
  PreventRemoval      : TPREVENT_MEDIA_REMOVAL;
  T                   : Integer;
begin
  LettreLecteur:=Uppercase(LettreLecteur);
  FormatLettreLecteur:=Format('%s:',[LettreLecteur]);
  Result:=False;
  case GetDriveType(PChar(FormatLettreLecteur)) of
    DRIVE_REMOVABLE:
    begin
      //Mise en place du format désirer
      FormatLettreLecteur:=Format('\\.\%s:',[LettreLecteur]);
      PreventRemoval.PreventMediaRemoval:=False;
      //Création du volume
      HandleVolume:=CreateFile(PChar(FormatLettreLecteur),GENERIC_READ or GENERIC_WRITE,
                                FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
      //Verrouillage du volume
      for T := 0 to NbdeFois do
      begin
        if DeviceIoControl(HandleVolume,FSCTL_LOCK_VOLUME, nil,0,nil,0,lpBytesReturned,nil) then
        begin
          //Démontage du volume
          DeviceIoControl(HandleVolume,FSCTL_DISMOUNT_VOLUME, nil,0,nil,0,lpBytesReturned,nil);
          //Control du volume
          DeviceIoControl(HandleVolume,IOCTL_STORAGE_MEDIA_REMOVAL,
                          @PreventRemoval,SizeOf(TPREVENT_MEDIA_REMOVAL),nil,0,lpBytesReturned,nil);
          //Ejection du volume
          DeviceIoControl(HandleVolume,IOCTL_STORAGE_EJECT_MEDIA,nil,0,nil,0,lpBytesReturned,nil);
          //Déverrouillage du volume
          Result:=DeviceIoControl(HandleVolume,FSCTL_UNLOCK_VOLUME,nil,0,nil,0,lpBytesReturned,nil);
          FormatLettreLecteur:=Format('%s:\',[LettreLecteur]);
          //Avertir le système que l'USB est demonter
          ShChangeNotify(SHCNE_MEDIAREMOVED,SHCNF_PATH,PChar(FormatLettreLecteur),Nil);
          Break;
        end
        else
        begin
          Result:=False;
          Sleep(Tempo);
        end;
      end;
      //Libération volume
      CloseHandle(HandleVolume);
    end
    else
      Result:=False;
  end;
end;

procedure TRetirerUSB.EjectClick(Sender: TObject);
var
  I : Integer;
begin
  Volume:='';
  for I:=0 to ListeUSB.Count-1 do
  begin
    if ListeUSB.Checked[i] then
    begin
      Volume:=ListeUSB.Items.Strings[i];
      //Ejection des volumes selectionner,avec 3 tentatives en cas d'échec, espacé de 2000 ms
      If EjectUSB(Volume[1],2000,3) then
      begin
        MessageDlg('Le périphérique USB-Lecteur '+Volume[1]+' peut-être retirer en toute sécurité!',mtInformation,[mbOk],0);
        ListeUSB.Items.Strings[i]:=Volume[1]+':\ Waiting for extraction'
      end
      else
        MessageDlg('Le périphérique USB-Lecteur '+Volume[1]+' ne peut pas être retirer !'+
                    #13#10+#13#10+
                   'Cause possible :'+#13#10+#13#10+
                   '- le lecteur '+Volume[1]+' est en cours d''utilisation.'+#13#10+
                   '- le lecteur '+Volume[1]+' n''existe pas.'+#13#10+
                   '- le lecteur '+Volume[1]+' a un problème inconnu.',mtWarning,[mbOk],0);
    end;
  end;
end;

Procedure ListeLecteurs(Lecteurs:TStrings;Types:Integer);
var
  Num   : integer;
  Bits  : set of 0..25;
  Disque: String;
begin
  //Récupération du nombres de disques logiques
  integer(Bits):=GetLogicalDrives;
  //Récupération des lettres des ports choisi ici DRIVE_REMOVABLE
  for Num := 0 to 25 do
    if Num in Bits then
    begin
      Disque:=Char(Num+Ord('A'))+':';
      if Types=GetDriveType(PChar(Disque)) then
        Lecteurs.Append(Char(Num+Ord('A'))+':\ Connected');
    end;
end;

procedure TRetirerUSB.FormActivate(Sender: TObject);
begin
  ListeUSB.Clear;
  ListeLecteurs(ListeUSB.Items,DRIVE_REMOVABLE);
end;

end.
