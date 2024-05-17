Unit MatrixUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls,
    LinkedList;

Type
    TuVCLMatrix = Class(TForm)
        LbFormInfo: TLabel;
        StrGrMatrix: TStringGrid;
        Procedure FormShow(Sender: TObject);
    Private
        FNodes: TArray<TList<Integer>>;
        Procedure PaintMatrix();
        Procedure PaintForm();
        Procedure PaintField();
    Public
        Property Nodes: TArray < TList < Integer >> Write FNodes;
    End;

Var
    UVCLMatrix: TuVCLMatrix;

Implementation

{$R *.dfm}

Procedure TuVCLMatrix.PaintField;
Var
    Size, I: Integer;
Begin
    Size := Length(FNodes);
    StrGrMatrix.FixedCols := 1;
    StrGrMatrix.ColCount := StrGrMatrix.FixedCols + Size;
    StrGrMatrix.FixedRows := 1;
    StrGrMatrix.RowCount := StrGrMatrix.FixedRows + Size;
    For I := 1 To Size Do
        StrGrMatrix.Cells[I, 0] := IntToStr(I);
    For I := 1 To Size Do
        StrGrMatrix.Cells[0, I] := IntToStr(I);
End;

procedure TuVCLMatrix.PaintForm;
Const
    OffSet : Integer = 60;
Var
    Size, SideWidth: Integer;
begin
    SideWidth := StrGrMatrix.Margins.Left * 2 + (StrGrMatrix.DefaultColWidth + 2) * (Length(FNodes) + 1);
    Self.Constraints.MinHeight := SideWidth + OffSet;
    Self.Constraints.MinWidth := SideWidth;
    Self.ClientHeight := SideWidth + OffSet;
    Self.ClientWidth := SideWidth;
end;

Procedure TuVCLMatrix.PaintMatrix;
Var
    I, J, K: Integer;
    TempArray: TArray<Integer>;
Begin
    For I := 0 To High(FNodes) Do
    Begin
        TempArray := FNodes[I].ToArray();
        K := 0;
        For J := 0 To High(FNodes) Do
        Begin
            If (K < Length(TempArray)) And (TempArray[K] = J) Then
            Begin
                StrGrMatrix.Cells[J + 1, I + 1] := '1';
                Inc(K);
            End
            Else
                StrGrMatrix.Cells[J + 1, I + 1] := '0';
        End;
    End;
End;

Procedure TuVCLMatrix.FormShow(Sender: TObject);
Begin
    // создание окна нужного размера
    PaintForm();
    // отрисовка полей
    PaintField();
    // отрисовка матрицы
    PaintMatrix();
End;

End.
