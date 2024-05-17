Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, System.ImageList,
    Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, AddNodeUnit, LinkedList, DeleteUnit,
    MatrixUnit, Vcl.Menus, AboutTheDeveloperUnit7_1, InstructionUnit7_1;

Type
    TuVCLMain = Class(TForm)
        BitBtnAdd: TBitBtn;
        ImageList1: TImageList;
        BitBtnDelete: TBitBtn;
        ListBNodes: TListBox;
        BitBtnShowMatrix: TBitBtn;
        ImageList2: TImageList;
    LbFormInfo: TLabel;
    MainMenu1: TMainMenu;
    btFile: TMenuItem;
    btOpenFile: TMenuItem;
    btSaveFile: TMenuItem;
    btInstruction: TMenuItem;
    btAboutTheDeveloper: TMenuItem;
        Procedure BitBtnAddClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Function Max(Item1, Item2: Integer): Integer;
        Procedure BitBtnDeleteClick(Sender: TObject);
        Procedure BitBtnShowMatrixClick(Sender: TObject);
    procedure btInstructionClick(Sender: TObject);
    procedure btAboutTheDeveloperClick(Sender: TObject);
    Private
        Nodes: TArray<TList<Integer>>;
        Class Function EqualityComparer(Var Item1, Item2: Integer)
            : Boolean; Static;
        Class Function Comparer(Var Item1, Item2: Integer): Integer; Static;
        Procedure ReWrite();
    Public

    End;

Var
    UVCLMain: TuVCLMain;

Implementation

{$R *.dfm}

Procedure TuVCLMain.BitBtnAddClick(Sender: TObject);
Var
    MainNode, PairNode, OldSize, NewSize: Integer;
    I: Integer;
Begin
    OldSize := Length(Nodes);
    Application.CreateForm(TuVCLAddNode, UVCLAddNode);
    UVCLAddNode.ShowModal;
    MainNode := UVCLAddNode.MainNode;
    PairNode := UVCLAddNode.PairNode;
    If (PairNode <> -1) And (MainNode <> -1) Then
    Begin
        NewSize := Max(MainNode, PairNode);
        If OldSize < NewSize Then
        Begin
            SetLength(Nodes, NewSize);
            For I := OldSize To High(Nodes) Do
            Begin
                Nodes[I] := TList<Integer>.Create();
                Nodes[I].Comparer := UVCLMain.Comparer;
                Nodes[I].EqualityComparer := UVCLMain.EqualityComparer;
            End;
        End;
        Nodes[MainNode - 1].TryAdd(PairNode - 1);
        Nodes[PairNode - 1].TryAdd(MainNode - 1);
        ReWrite();
    End;
    UVCLAddNode.Destroy();
    UVCLAddNode := Nil;
    If Length(Nodes) > 1 Then
        BitBtnShowMatrix.Enabled := True
    Else
        BitBtnShowMatrix.Enabled := False;
End;

Procedure TuVCLMain.BitBtnDeleteClick(Sender: TObject);
Var
    MainNode, PairNode, OldSize, NewSize: Integer;
    I: Integer;
Begin
    Application.CreateForm(TuVCLDelete, UVCLDelete);
    UVCLDelete.Count := Length(Nodes);
    UVCLDelete.ShowModal;
    MainNode := UVCLDelete.MainNode;
    PairNode := UVCLDelete.PairNode;
    If (PairNode <> -1) And (MainNode <> -1) And
        (Nodes[MainNode - 1].FindByValue(PairNode - 1) <> -1) Then
    Begin
        Nodes[MainNode - 1].Delete(PairNode - 1);
        If Nodes[PairNode - 1].FindByValue(MainNode - 1) <> -1 Then
            Nodes[PairNode - 1].Delete(MainNode - 1);
        I := Length(Nodes) - 1;
        While (I > 0) And (Nodes[I].Count = 0) Do
        Begin
            Nodes[I].Destroy();
            Dec(I);
        End;
        Setlength(Nodes, I + 1);
        ReWrite();
    End;
    UVCLDelete.Destroy();
    UVCLDelete := Nil;
    If Length(Nodes) > 1 Then
        BitBtnShowMatrix.Enabled := True
    Else
        BitBtnShowMatrix.Enabled := False;
End;

Procedure TuVCLMain.BitBtnShowMatrixClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLMatrix, UVCLMatrix);
    UVCLMatrix.Nodes := Nodes;
    UVCLMatrix.ShowModal;
    UVCLMatrix.Destroy();
    UVCLMatrix := Nil;
End;

procedure TuVCLMain.btAboutTheDeveloperClick(Sender: TObject);
begin
    Application.CreateForm(TuVCLAboutTheDeveloper,uVCLAboutTheDeveloper);
    uVCLAboutTheDeveloper.ShowModal;
    uVCLAboutTheDeveloper.Destroy();
    uVCLAboutTheDeveloper := nil;
end;

procedure TuVCLMain.btInstructionClick(Sender: TObject);
begin
    Application.CreateForm(TuVCLInstruction,uVCLInstruction);
    uVCLInstruction.ShowModal;
    uVCLInstruction.Destroy();
    uVCLInstruction := nil;
end;

Class Function TuVCLMain.Comparer(Var Item1, Item2: Integer): Integer;
Var
    Answer: Integer;
Begin
    If Item1 > Item2 Then
        Answer := 1
    Else
        If Item1 = Item2 Then
            Answer := 0
        Else
            Answer := -1;
    Comparer := Answer;
End;

Class Function TuVCLMain.EqualityComparer(Var Item1, Item2: Integer): Boolean;
Var
    Answer: Boolean;
Begin
    Answer := False;
    If Item1 = Item2 Then
        Answer := True;
    EqualityComparer := Answer;
End;

Procedure TuVCLMain.FormCreate(Sender: TObject);
Begin
    SetLength(Nodes, 1);
    Nodes[0] := TList<Integer>.Create();
    Nodes[0].Comparer := UVCLMain.Comparer;
    Nodes[0].EqualityComparer := UVCLMain.EqualityComparer;
    ReWrite();
End;

Procedure TuVCLMain.FormDestroy(Sender: TObject);
Var
    I: Integer;
Begin
    For I := 0 To High(Nodes) Do
    Begin
        Nodes[I].Clear;
        Nodes[I].Destroy();
    End;
End;

Function TuVCLMain.Max(Item1, Item2: Integer): Integer;
Var
    Answer: Integer;
Begin
    If Item1 > Item2 Then
        Answer := Item1
    Else
        Answer := Item2;
    Max := Answer;
End;

Procedure TuVCLMain.ReWrite;
Var
    I: Integer;
    TempNodes: TArray<Integer>;
    J: Integer;
    TempStr: String;
Begin
    ListBNodes.Clear;
    For I := 0 To High(Nodes) Do
    Begin
        TempNodes := Nodes[I].ToArray();
        TempStr := 'Вершина ' + IntToStr(I + 1) + ': ';
        For J := 0 To High(TempNodes) Do
        Begin
            TempStr := Concat(TempStr, IntToStr(TempNodes[J] + 1), ', ');
        End;
        If TempStr[Length(TempStr) - 1] = ',' Then
            Delete(TempStr, Length(TempStr) - 1, 2);
        ListBNodes.AddItem(TempStr, Self);
    End;
End;

End.
