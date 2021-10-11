program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {RetirerUSB};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRetirerUSB, RetirerUSB);
  Application.Run;
end.
