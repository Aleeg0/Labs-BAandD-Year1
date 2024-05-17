Program Lab5_1;

Uses
    Vcl.Forms,
    Vcl.Themes,
    Vcl.Styles,
    AboutTheDeveloperUnit5_1
        In 'AboutTheDeveloperUnit5_1.pas' {uVCLAboutTheDeveloper} ,
    BackendUnit5_1 In 'BackendUnit5_1.pas',
    ExitUnit5_1 In 'ExitUnit5_1.pas' {uVCLExit} ,
    InstructionUnit5_1 In 'InstructionUnit5_1.pas' {uVCLInstruction} ,
    MainFormUnit5_1 In 'MainFormUnit5_1.pas' {uVCLMain} ,
    OutputSortedArrayUnit5_1
        In 'OutputSortedArrayUnit5_1.pas' {uVCLOutputSortedArray};

{$R *.res}

Begin
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TuVCLMain, UVCLMain);
    Application.Run;

End.
