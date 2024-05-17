Unit GraphUnit;

Interface

Uses
    Winapi.Windows,
    System.SysUtils, System.Classes,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
    LinkedList, EdgeUnit, Vcl.StdCtrls;

Type
    TuVCLGraph = Class(TForm)
        PaintBox: TPaintBox;
        Procedure CreateParams(Var Params: TCreateParams); Override;
        Procedure FormShow(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure PaintBoxPaint(Sender: TObject);
    Private
        FEdges: TList<TEdge>;
        FNodes: TArray<TList<Integer>>;
        Procedure DrawVerteces(Const CenterX, CenterY, Distance: Integer;
            Const RotateAngle: Real);
        Procedure DrawVertex(Const X, Y: Integer; Const Text: String);
        Procedure DrawEdges(Const CenterX, CenterY, Distance: Integer;
            Const RotateAngle: Real; IndexV: Integer);
        Procedure DrawEdge(Const X1, Y1, X2, Y2: Integer; Const Text: String);
    Public
        Property Edges: TList<TEdge> Write FEdges;
        Property Nodes: TArray < TList < Integer >> Write FNodes;
    End;

Var
    UVCLGraph: TuVCLGraph;

Implementation

{$R *.dfm}

Uses
    Math;

Const
    VertexSize = 30;

Procedure TuVCLGraph.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    Params.ExStyle := Params.ExStyle Or WS_EX_APPWINDOW;
End;

Procedure TuVCLGraph.FormShow(Sender: TObject);
Begin
    PaintBoxPaint(PaintBox);
End;

Procedure TuVCLGraph.DrawEdge(Const X1, Y1, X2, Y2: Integer;
    Const Text: String);
Begin
    With PaintBox.Canvas Do
    Begin
        MoveTo(X1 + VertexSize Div 2, Y1 + VertexSize Div 2);
        LineTo(X2 + VertexSize Div 2, Y2 + VertexSize Div 2);
        TextOut((X1 + X2) Div 2, (Y1 + Y2) Div 2, Text);
    End;
End;

Procedure TuVCLGraph.DrawEdges(Const CenterX, CenterY, Distance: Integer;
    Const RotateAngle: Real; IndexV: Integer);
Var
    PairNodes: TArray<Integer>;
    CurEdge: TEdge;
    CurEdgesArr: TArray<TEdge>;
    I, J: Integer;
Begin
    PairNodes := FNodes[IndexV].ToArray();
    For I := 0 To High(PairNodes) Do
    Begin
        CurEdge.A := IndexV;
        CurEdge.B := PairNodes[I];
        CurEdgesArr := FEdges.FindAllByValue(CurEdge);
        For J := 0 To High(CurEdgesArr) Do
            // добавить вес
            DrawEdge(Round(CenterX + Distance * Sin(IndexV * RotateAngle)),
                Round(CenterY - Distance * Cos(IndexV * RotateAngle)),
                Round(CenterX + Distance * Sin((PairNodes[I]) * RotateAngle)),
                Round(CenterY - Distance * Cos((PairNodes[I]) * RotateAngle)),
                IntToStr(CurEdgesArr[J].Weight));
    End;
End;

Procedure TuVCLGraph.DrawVerteces(Const CenterX, CenterY, Distance: Integer;
    Const RotateAngle: Real);
Var
    I: Integer;
    Angle: Real;
Begin
    Angle := 0;
    For I := 0 To High(FNodes) Do
    Begin
        DrawEdges(CenterX, CenterY, Distance, RotateAngle, I);
        DrawVertex(Round(CenterX + Distance * Sin(Angle)),
            Round(CenterY - Distance * Cos(Angle)), IntToStr(I + 1));
        Angle := Angle + RotateAngle;
    End;
End;

Procedure TuVCLGraph.DrawVertex(Const X, Y: Integer; Const Text: String);
Begin
    With PaintBox.Canvas Do
    Begin
        Ellipse(X, Y, X + VertexSize, Y + VertexSize);
        TextOut(X + (VertexSize - TextWidth(Text)) Div 2,
            Y + (VertexSize - TextHeight(Text)) Div 2, Text);
    End;
End;

Procedure TuVCLGraph.FormKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

Procedure TuVCLGraph.PaintBoxPaint(Sender: TObject);
Var
    CenterX, CenterY, Distance: Integer;
    RotateAngle: Real;
    Count: Integer;
Begin
    Count := Length(FNodes);
    If Count <> 0 Then
    Begin
        PaintBox.Canvas.Pen.Width := 1;
        PaintBox.Canvas.Brush.Color := ClWhite;
        PaintBox.Canvas.Pen.Color := ClWhite;
        CenterX := PaintBox.Width Div 2;
        CenterY := PaintBox.Height Div 2;
        Distance := Round(LogN(2, Count) * VertexSize);
        RotateAngle := 2 * Pi / Count;

        DrawVerteces(CenterX, CenterY, Distance, RotateAngle);
    End;
End;

End.
