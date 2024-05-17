Unit OutputUnit5_2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, BackendUnit5_2;

Type
    TuVCLOutputTree = Class(TForm)
        ImTree: TImage;
        Procedure FormCreate(Sender: TObject);
    Private
        FRadius: Integer;
        Procedure DrawRoot(Tree: PtrRoot; X, Y: Integer; Level: Integer);
        Procedure Circle(X, Y: Integer);
    Public
        { Public declarations }
    End;

Var
    UVCLOutputTree: TuVCLOutputTree;

Implementation

{$R *.dfm}

Procedure TuVCLOutputTree.Circle(X, Y: Integer);
Var
    X1, Y1, X2, Y2: Integer;
Begin
    X1 := X - FRadius;
    X2 := X + FRadius;

    Y1 := Y - FRadius;
    Y2 := Y + FRadius;
    ImTree.Canvas.Ellipse(X1, Y1, X2, Y2);
End;

Procedure TuVCLOutputTree.DrawRoot(Tree: PtrRoot; X, Y: Integer;
    Level: Integer);
Var
    Canvas : TCanvas;
    CircleBottom : Integer;
Begin
    If Tree <> Nil Then
    Begin
        Canvas := ImTree.Canvas;
        Circle(X, Y);
        CircleBottom := Y + FRadius;
        Canvas.TextOut(X - Canvas.Font.Size, Y - Canvas.Font.Size,
            IntToStr(Tree.FValue));
        If Tree.FLeft <> Nil Then
        Begin
            Canvas.MoveTo(X, CircleBottom);
            Canvas.LineTo(X - FRadius - Level * FRadius, CircleBottom + FRadius);
        End;
        If Tree.FRight <> Nil Then
        Begin
            Canvas.MoveTo(X, CircleBottom);
            Canvas.LineTo(X + FRadius + Level * FRadius, CircleBottom + FRadius);
        End;
        DrawRoot(Tree.FLeft, X - FRadius - Level * FRadius,
            CircleBottom + FRadius + (FRadius Div 2), Level Div 2);
        DrawRoot(Tree.FRight, X + FRadius + Level * FRadius,
            CircleBottom + FRadius + (FRadius Div 2), Level Div 2);
    End;
End;

Procedure TuVCLOutputTree.FormCreate(Sender: TObject);
Var
    CenterX, CenterY: Integer;
Begin
    FRadius := 25;
    ImTree.Canvas.Pen.Color := clBlack;
    ImTree.Canvas.Brush.Color := clWebDarkSlateBlue;
    ImTree.Canvas.FillRect(ImTree.ClientRect);
    ImTree.Canvas.Brush.Color := clWebBisque;
    ImTree.Canvas.Pen.Width := 2;
    ImTree.Canvas.Font.Size := 10;
    CenterX := ImTree.Width Div 2;
    DrawRoot(Tree.Head,CenterX,FRadius,5);
End;

End.
