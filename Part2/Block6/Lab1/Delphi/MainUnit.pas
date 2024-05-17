Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.Jpeg,
    Vcl.Imaging.Pngimage, Vcl.StdCtrls, System.ImageList, Vcl.ImgList,
    Vcl.Menus,
    InstructionUnit6_1, ExitUnit6_1, AboutTheDeveloperUnit6_1;

Type
    TSpeed = (SVeryLow, SLOw, SMidle, SHigh, SVeryHigh);

    TuVCLMain = Class(TForm)
        ImVolna: TImage;
        ImKorablick: TImage;
        LbInfo: TLabel;
        LSpeedInfo: TLabel;
        LbSpeed: TLabel;
        ImSpeedometer: TImage;
        ImLSpeeds: TImageList;
        MainMenu1: TMainMenu;
        BtInstruction: TMenuItem;
        BtAboutTheDeveloper: TMenuItem;
        Procedure FormKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormCreate(Sender: TObject);
        Procedure BtInstructionClick(Sender: TObject);
        Procedure BtAboutTheDeveloperClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
    Private
        FSpeed: Integer;
        FSpeedType: TSpeed;
        Procedure PrintSpeed();
        Procedure ChangeImage();
    Public
        { Public declarations }
    End;

Var
    UVCLMain: TuVCLMain;

Implementation

{$R *.dfm}

Procedure TuVCLMain.BtAboutTheDeveloperClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLAboutTheDeveloper, UVCLAboutTheDeveloper);
    UVCLAboutTheDeveloper.ShowModal;
    UVCLAboutTheDeveloper.Destroy();
    UVCLAboutTheDeveloper := Nil;
End;

Procedure TuVCLMain.BtInstructionClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLInstruction, UVCLInstruction);
    UVCLInstruction.ShowModal;
    UVCLInstruction.Destroy();
    UVCLInstruction := Nil;
End;

Procedure TuVCLMain.ChangeImage();
Begin
    ImSpeedometer.Picture.Assign(Nil);
    ImLSpeeds.GetBitmap(Integer(FSpeedType), ImSpeedometer.Picture.Bitmap);
End;

Procedure TuVCLMain.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    Application.CreateForm(TuVCLExit, UVCLExit);
    UVCLExit.ShowModal;
    CanClose := UVCLExit.GetStatus();
    UVCLExit.Destroy();
    UVCLExit := Nil;
End;

Procedure TuVCLMain.FormCreate(Sender: TObject);
Begin
    LbInfo.Caption := 'Программа позваляет управлять корабликом:' + #13#10 +
        'A(<-) - движение влево;' + #13#10 + 'D(->) - движение вправо;' + #13#10
        + 'Для увеличения скорости нажмите S;' + #13#10 +
        'Для уменьшения скорости нажмите B;' + #13#10;
    ImKorablick.Left := UVCLMain.Width Div 2;
    FSpeed := 2;
    FSpeedType := SVeryLow;
    PrintSpeed();
End;

Procedure TuVCLMain.FormKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (Key = VK_RIGHT) Then
    Begin
        If ImKorablick.Left > UVCLMain.Width Then
            ImKorablick.Left := -ImKorablick.Width;
        ImKorablick.Left := ImKorablick.Left + FSpeed;
    End;
    If (Key = VK_LEFT) Then
    Begin
        If ImKorablick.Left < -ImKorablick.Width Then
            ImKorablick.Left := UVCLMain.Width;
        ImKorablick.Left := ImKorablick.Left - FSpeed;
    End;
End;

Procedure TuVCLMain.FormKeyPress(Sender: TObject; Var Key: Char);
CONST
    MAX_Speed: Integer = 24;
    MIN_Speed: Integer = 2;
    COEF: Integer = 5;
    CHANGE_COEF: Integer = 2;
    RIGHT_KEYS = ['d', 'D'];
    LEFT_KEYS = ['a', 'A'];
Begin
    If (Key In RIGHT_KEYS) Then
    Begin
        If ImKorablick.Left > UVCLMain.Width Then
            ImKorablick.Left := -ImKorablick.Width;
        ImKorablick.Left := ImKorablick.Left + FSpeed;
    End;
    If (Key In LEFT_KEYS) Then
    Begin
        If ImKorablick.Left < -ImKorablick.Width Then
            ImKorablick.Left := UVCLMain.Width;
        ImKorablick.Left := ImKorablick.Left - FSpeed;
    End;
    If (Key = 's') And (FSpeed <> MAX_Speed) Then
    Begin
        Inc(FSpeed, CHANGE_COEF);
        PrintSpeed();

    End;
    If (Key = 'b') And (FSpeed <> MIN_Speed) Then
    Begin
        Dec(FSpeed, CHANGE_COEF);
        PrintSpeed();
    End;
    FSpeedType := TSpeed(FSpeed Div COEF);
    ChangeImage();
End;

Procedure TuVCLMain.PrintSpeed;
Begin
    LbSpeed.Caption := IntToStr(FSpeed) + ' Км/ч';
End;

End.
