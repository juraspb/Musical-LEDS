program Service;

uses
  Forms,
  SerialLink in 'SerialLink.pas',
  CMU in 'CMU.pas' {DSForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDSForm, DSForm);
  Application.Run;
end.
