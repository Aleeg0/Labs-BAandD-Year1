Unit ExitUnit6_2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
    System.ImageList, Vcl.ImgList, Vcl.Buttons, Vcl.Imaging.Pngimage;

Type
    TuVCLExit = Class(TForm)
        ExitInfo: TLabel;
        QuestionImage: TImage;
        YesButton: TBitBtn;
        NoButton: TBitBtn;
        ImageList1: TImageList;
        Procedure YesButtonClick(Sender: TObject);
        Procedure NoButtonClick(Sender: TObject);
    Private
        IsExit: Boolean;
        ButtonPressed: Boolean;
    Public
        Constructor Create();
        Function GetStatus(): Boolean;
    End;

Var
    uVCLExit: TuVCLExit;

Implementation

{$R *.dfm}

Constructor TuVCLExit.Create;
Begin
    IsExit := False;
End;

Function TuVCLExit.GetStatus: Boolean;
Begin
    GetStatus := IsExit;
End;

Procedure TuVCLExit.NoButtonClick(Sender: TObject);
Begin
    Close();
End;

Procedure TuVCLExit.YesButtonClick(Sender: TObject);
Begin
    IsExit := True;
    Close();
End;

End.
