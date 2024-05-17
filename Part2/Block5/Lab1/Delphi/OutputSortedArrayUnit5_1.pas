Unit OutputSortedArrayUnit5_1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,BackendUnit5_1;

Type
    TuVCLOutputSortedArray = Class(TForm)
        ElementsOfNewArray: TStringGrid;
        Procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Private
        FIsClosed : Boolean;
    Public
        Property IsClosed : Boolean read FIsClosed;
    End;

Var
    uVCLOutputSortedArray: TuVCLOutputSortedArray;

Implementation

{$R *.dfm}

procedure TuVCLOutputSortedArray.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    FIsClosed := True;
end;

Procedure TuVCLOutputSortedArray.FormCreate(Sender: TObject);
Var
    Size, I: Integer;
Begin
    Size := MergedList.Count;
    ElementsOfNewArray.ColCount := Size + 1;
    ElementsOfNewArray.RowCount := 2;
    ElementsOfNewArray.FixedCols := 1;
    ElementsOfNewArray.FixedRows := 1;
    ElementsOfNewArray.Cells[0, 0] := '№';
    ElementsOfNewArray.Cells[0, 1] := 'Элемент';
    For I := 1 To Size Do
    Begin
        ElementsOfNewArray.Cells[I, 0] := IntToStr(I);
        ElementsOfNewArray.Cells[I, 1] := IntToStr(MergedList[I - 1]);
    End;
End;

End.
