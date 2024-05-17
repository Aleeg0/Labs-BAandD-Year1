program Lab6_1;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {uVCLMain},
  Vcl.Themes,
  Vcl.Styles,
  AboutTheDeveloperUnit6_1 in 'AboutTheDeveloperUnit6_1.pas' {uVCLAboutTheDeveloper},
  ExitUnit6_1 in 'ExitUnit6_1.pas' {uVCLExit},
  InstructionUnit6_1 in 'InstructionUnit6_1.pas' {uVCLInstruction};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TuVCLMain, uVCLMain);
  Application.Run;
end.
