Program Lab4_2;

uses
  Vcl.Forms,
  AboutTheDeveloperUnit4_2 in 'AboutTheDeveloperUnit4_2.pas' {uVCLAboutTheDeveloper},
  ExitUnit4_2 in 'ExitUnit4_2.pas' {uVCLExit},
  InstructionUnit4_2 in 'InstructionUnit4_2.pas' {uVCLInstruction},
  MainFormUnit4_2 in 'MainFormUnit4_2.pas' {uVCLMain},
  Vcl.Themes,
  Vcl.Styles,
  OutputSortedArrayUnit4_2 in 'OutputSortedArrayUnit4_2.pas' {uVCLOutputSortedArray},
  BackendUnit4_2 in 'BackendUnit4_2.pas';

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.CreateForm(TuVCLMain, uVCLMain);
  Application.CreateForm(TuVCLAboutTheDeveloper, uVCLAboutTheDeveloper);
  Application.CreateForm(TuVCLInstruction, uVCLInstruction);
  Application.Run;

End.
