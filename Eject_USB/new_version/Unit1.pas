unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, EjectUSB, StdCtrls, CheckLst;

type
  TForm1 = class(TForm)
    Button1: TButton;
    CheckListBox1: TCheckListBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
    Procedure EtatConnectionUSB(var Msg: TMessage);Message WM_DEVICECHANGE;
  public
    { Déclarations publiques }
  end;

var
  Form1 : TForm1;
  Eject : Boolean;

implementation

{$R *.dfm}

Procedure TForm1.EtatConnectionUSB(var Msg: TMessage);
begin
// Déconnexion physique / Connexion physique
    if (Msg.wParam = $8004) or (Msg.wParam = $8000) then
        if DEV_BROADCAST_HDR(Msg.LParam)^.dbch_devicetype=2 then
            if DEV_BROADCAST_VOLUME(Msg.LParam)^.dbcv_flags=0 then
                if not Eject then
                begin
                    CheckListBox1.Clear;
                    Liste_USB(CheckListBox1.Items,True,True,True);
                end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  I     : Integer;
  Drive : String;
begin
    for I := 0 to CheckListBox1.Count - 1 do
        if CheckListBox1.Checked[I] then
        begin
            Eject:=True;
            Drive:=CheckListBox1.Items.Strings[i];
            // Eject_USB(LetVol: String;Rep,TempRep: Integer;MessageEject,MultiSupport: Boolean);
            // LetVol : Lettre du volume à Ejecter
            // Rep : Nombre de tentative d'ejection
            // TempRep : Temps en ms entre chaque tentative d'ejection
            // MessageEject : Affichage de la bulle d'ejection et des erreurs
            // MultiSupport : Pour les lecteurs MultiCartes par exemple cela supprime l'adaptateur complet
            if MessageDlg('Extraire le support complet ?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
            begin
                if Eject_USB(Drive[1],4,300,True,True) then
                    CheckListBox1.ItemEnabled[I]:=False;
            end
            else
            begin
                if Eject_USB(Drive[1],4,300,True,False) then
                    CheckListBox1.ItemEnabled[I]:=False;
            end;
        end;
    CheckListBox1.Clear;
    Liste_USB(CheckListBox1.Items,True,True,True);
    Eject:=False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    CheckListBox1.Clear;
    Liste_USB(CheckListBox1.Items,True,True,True);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    CheckListBox1.Clear;
    // Liste_USB(Lecteurs:TStrings;DriveRemovable,DriveFixed,DriveCDRom:Boolean);
    // Lecteurs : Récupération des volumes dans un TStrings
    // DriveRemovable : Récupération des périphériques autres que disques et média USB
    // DriveFixed : Récupération des disques USB
    // DriveCDROM : Récupération des médias USB
    Liste_USB(CheckListBox1.Items,True,True,True);
end;

end.
