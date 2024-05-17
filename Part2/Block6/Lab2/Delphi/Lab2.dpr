Program Lab2;

Uses
    Vcl.Forms,
    MainUnit In 'MainUnit.pas' {uVCLMain} ,
    Vcl.Themes,
    Vcl.Styles,
    Backend In 'Backend.pas',
    AboutTheDeveloperUnit6_2
        In 'AboutTheDeveloperUnit6_2.pas' {uVCLAboutTheDeveloper} ,
    ExitUnit6_2 In 'ExitUnit6_2.pas' {uVCLExit} ,
    InstructionUnit6_2 In 'InstructionUnit6_2.pas' {uVCLInstruction};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.CreateForm(TuVCLMain, UVCLMain);
    Application.Run;

End.
