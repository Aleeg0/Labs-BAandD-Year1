Program Lab4_1;

Uses
    Vcl.Forms,
    UnitMain In 'UnitMain.pas' {uVCLMain} ,
    Vcl.Themes,
    Vcl.Styles,
    UnitAboutTheDeveloper
        In 'UnitAboutTheDeveloper.pas' {uVCLAboutTheDeveloper} ,
    UnitExit In 'UnitExit.pas' {uVCLExit} ,
    UnitInstruction In 'UnitInstruction.pas' {uVCLInstruction} ,
    UnitBackend In 'UnitBackend.pas',
    UnitDeleter In 'UnitDeleter.pas' {uVCLDeleter};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.CreateForm(TuVCLMain, UVCLMain);
    Application.Run;

End.
