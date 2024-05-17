Program Lab5_2;

Uses
    Vcl.Forms,
    AboutTheDeveloperUnit5_2
        In 'AboutTheDeveloperUnit5_2.pas' {uVCLAboutTheDeveloper} ,
    ExitUnit5_2 In 'ExitUnit5_2.pas' {uVCLExit} ,
    InstructionUnit5_2 In 'InstructionUnit5_2.pas' {uVCLInstruction} ,
    Vcl.Themes,
    Vcl.Styles,
    MainUnit5_2 In 'MainUnit5_2.pas' {uVCLMain} ,
    BackendUnit5_2 In 'BackendUnit5_2.pas',
    OutputUnit5_2 In 'OutputUnit5_2.pas' {uVCLOutputTree};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TuVCLMain, UVCLMain);
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.Run;

End.
