Unit OutputSortedArrayUnit4_2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids;

Type
    TuVCLOutputSortedArray = Class(TForm)
        ElementsOfNewArray: TStringGrid;
        Procedure FormCreate(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    uVCLOutputSortedArray: TuVCLOutputSortedArray;

Implementation

{$R *.dfm}

Uses MainFormUnit4_2, BackendUnit4_2;

Procedure TuVCLOutputSortedArray.FormCreate(Sender: TObject);
Var
    Size, I: Integer;
    SortedArray: TArray;
Begin
    SortedArray := ArraySorter.GetArray();
    Size := Length(SortedArray);
    ElementsOfNewArray.ColCount := Size + 1;
    ElementsOfNewArray.RowCount := 2;
    ElementsOfNewArray.FixedCols := 1;
    ElementsOfNewArray.FixedRows := 1;
    ElementsOfNewArray.Cells[0, 0] := '№';
    ElementsOfNewArray.Cells[0, 1] := 'Элемент';
    For I := 1 To Size Do
    Begin
        ElementsOfNewArray.Cells[I, 0] := IntToStr(I);
        ElementsOfNewArray.Cells[I, 1] := IntToStr(SortedArray[I - 1]);
    End;
End;

End.
