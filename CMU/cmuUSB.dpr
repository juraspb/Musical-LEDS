program cmuUSB;

uses
  Forms,
  SerialLink in 'SerialLink.pas',
  MNTR in 'MNTR.pas' {DSForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDSForm, DSForm);
  Application.Run;
end.
