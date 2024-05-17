Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, System.ImageList,
    Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, AddNodeUnit, LinkedList, DeleteUnit,
    MatrixUnit, Vcl.Menus, AboutTheDeveloperUnit, InstructionUnit, EdgeUnit,
    GraphUnit, FindMinPathUnit;

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
        BtFile: TMenuItem;
        BtOpenFile: TMenuItem;
        BtSaveFile: TMenuItem;
        BtInstruction: TMenuItem;
        BtAboutTheDeveloper: TMenuItem;
        BitBtnShowGraph: TBitBtn;
        BitBtnFindPath: TBitBtn;
        Procedure BitBtnAddClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Function Max(Item1, Item2: Integer): Integer;
        Procedure BitBtnDeleteClick(Sender: TObject);
        Procedure BitBtnShowMatrixClick(Sender: TObject);
        Procedure BtInstructionClick(Sender: TObject);
        Procedure BtAboutTheDeveloperClick(Sender: TObject);
        Procedure BitBtnShowGraphClick(Sender: TObject);
        Procedure BitBtnFindPathClick(Sender: TObject);
    Private
        EdgeList: TList<TEdge>;
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

Procedure TuVCLMain.BitBtnFindPathClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLFindPath, UVCLFindPath);
    UVCLFindPath.Edges := EdgeList.ToArray();
    UVCLFindPath.CountNodes := Length(Nodes);
    UVCLFindPath.ShowModal();
    UVCLFindPath.Destroy();
    UVCLFindPath := Nil;
End;

Procedure TuVCLMain.BitBtnAddClick(Sender: TObject);
Var
    MainNode, PairNode, OldSize, NewSize: Integer;
    I: Integer;
    Edge: TEdge;
Begin
    OldSize := Length(Nodes);
    Application.CreateForm(TuVCLAddNode, UVCLAddNode);
    UVCLAddNode.ShowModal;
    Edge := UVCLAddNode.Edge;
    If (Edge.A <> -1) And (Edge.B <> -1) Then
    Begin
        NewSize := Max(Edge.A, Edge.B) + 1;
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
        If Nodes[Edge.A].TryAdd(Edge.B) Then
            EdgeList.PushBack(Edge);
        ReWrite();
    End;
    UVCLAddNode.Destroy();
    UVCLAddNode := Nil;
    If Length(Nodes) > 1 Then
    Begin
        BitBtnShowMatrix.Enabled := True;
        BitBtnShowGraph.Enabled := True;
        BitBtnFindPath.Enabled := True;
    End
    Else
    Begin
        BitBtnShowMatrix.Enabled := False;
        BitBtnShowGraph.Enabled := False;
        BitBtnFindPath.Enabled := False;
    End;
End;

Procedure TuVCLMain.BitBtnDeleteClick(Sender: TObject);
Var
    MainNode, PairNode, OldSize, NewSize: Integer;
    I: Integer;
    Edge : TEdge;
Begin
    Application.CreateForm(TuVCLDelete, UVCLDelete);
    UVCLDelete.Count := Length(Nodes);
    UVCLDelete.ShowModal;
    Edge := UVCLDelete.Edge;
    If (Edge.A <> -1) And (Edge.B <> -1) And
        (Nodes[Edge.A].FindByValue(Edge.B) <> -1) Then
    Begin
        Nodes[Edge.A].Delete(Edge.B);
        EdgeList.Delete(Edge);
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
    Begin
        BitBtnShowMatrix.Enabled := True;
        BitBtnShowGraph.Enabled := True;
        BitBtnFindPath.Enabled := True;
    End
    Else
    Begin
        BitBtnShowMatrix.Enabled := False;
        BitBtnShowGraph.Enabled := False;
        BitBtnFindPath.Enabled := False;
    End;
End;

Procedure TuVCLMain.BitBtnShowGraphClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLGraph, UVCLGraph);
    UVCLGraph.Edges := EdgeList;
    UVCLGraph.Nodes := Nodes;
    UVCLGraph.ShowModal();
    UVCLGraph.Destroy();
    UVCLGraph := Nil;
End;

Procedure TuVCLMain.BitBtnShowMatrixClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLMatrix, UVCLMatrix);
    UVCLMatrix.Nodes := Nodes;
    UVCLMatrix.ShowModal;
    UVCLMatrix.Destroy();
    UVCLMatrix := Nil;
End;

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

Class Function TuVCLMain.Comparer(Var Item1, Item2: Integer): Integer;
Var
    Answer: Integer;
Begin
    If Item1 > Item2 Then
        Answer := 1
    Else If Item1 = Item2 Then
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
    EdgeList := TList<TEdge>.Create();
    EdgeList.Comparer := EdgeUnit.Comparer;
    EdgeList.EqualityComparer := EdgeUnit.EqualityComparer;
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
        TempStr := 'Город ' + IntToStr(I + 1) + ': ';
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
