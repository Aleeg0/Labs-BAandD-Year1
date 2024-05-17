Unit FindMinPathUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, LinkedList, EdgeUnit,
    Generics.Collections, BufferHandler;

Type
    TuVCLFindPath = Class(TForm)
        LbFormInfo: TLabel;
        LbStartNodeInfo: TLabel;
        LbEndNodeInfo: TLabel;
        EdStartNode: TEdit;
        EdEndNode: TEdit;
        BtnFind: TButton;
        LbMinPath: TLabel;
        Procedure BtnFindClick(Sender: TObject);
        Procedure EdStartNodeChange(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure EdEndNodeChange(Sender: TObject);
    Private
        FEdges: TArray<TEdge>;
        FCountNodes: Integer;
        BufferHandler: TBufferHandler;
        Function FindMinPath(StartPoint, FinshPoint: Integer): TArray<Integer>;
    Public
        Property Edges: TArray<TEdge> Write FEdges;
        Property CountNodes: Integer Write FCountNodes;
    End;

Var
    UVCLFindPath: TuVCLFindPath;

Implementation

{$R *.dfm}
{ TuVCLFindPath }

Procedure TuVCLFindPath.BtnFindClick(Sender: TObject);
Const
    MIN: UInt32 = 1;
Var
    MinPath: TArray<Integer>;
    I: Integer;
    TempStr: String;
Begin
    BufferHandler.EditText := EdStartNode.Text;
    If Not BufferHandler.CheckInput(TpUInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверный тип вершины. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    If Not BufferHandler.CheckRange(MIN, FCountNodes, TpUInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверные границы. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    BufferHandler.EditText := EdEndNode.Text;
    If Not BufferHandler.CheckInput(TpUInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверный тип вершины. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    If Not BufferHandler.CheckRange(MIN, FCountNodes, TpUInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверные границы. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    MinPath := FindMinPath(StrToInt(EdStartNode.Text) - 1,
        StrToInt(EdEndNode.Text) - 1);
    If Length(MinPath) <> 0 Then
    Begin
        TempStr := 'Минимальный путь:' + #13#10;
        For I := 0 To High(MinPath) Do
            TempStr := Concat(TempStr, IntToStr(MinPath[I] + 1), '->');
        If TempStr[Length(TempStr)] = '>' Then
            Delete(TempStr, Length(TempStr) - 1, 2);
        LbMinPath.Caption := TempStr;
    End
    Else
        LbMinPath.Caption := 'Минимальный путь не был найден!';
End;

Procedure TuVCLFindPath.EdEndNodeChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdEndNode.Text;
    BufferHandler.DeleteLeadingZeros(TpUInteger);
    EdEndNode.Text := BufferHandler.EditText;
    BtnFind.Enabled := Not String.IsNullOrEmpty(EdStartNode.Text) And
        Not String.IsNullOrEmpty(EdEndNode.Text);
End;

Procedure TuVCLFindPath.EdStartNodeChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdStartNode.Text;
    BufferHandler.DeleteLeadingZeros(TpUInteger);
    EdStartNode.Text := BufferHandler.EditText;
    BtnFind.Enabled := Not String.IsNullOrEmpty(EdStartNode.Text) And
        Not String.IsNullOrEmpty(EdEndNode.Text);
End;

Function TuVCLFindPath.FindMinPath(StartPoint, FinshPoint: Integer)
    : TArray<Integer>;
Const
    INF: Integer = 100;
Var
    I, J: Integer;
    From: TArray<Integer>;
    Dist: TArray<Integer>;
    Path: TList<Integer>;
    Count: Integer;
Begin
    SetLength(Dist, FCountNodes);
    SetLength(From, FCountNodes);
    For I := 0 To High(Dist) Do
    Begin
        Dist[I] := INF;
        From[I] := -1;
    End;
    Dist[StartPoint] := 0;
    Count := FCountNodes - 2;
    For I := 0 To Count Do
        For J := 0 To High(FEdges) Do
            If (Dist[FEdges[J].A] <> INF) And
                (Dist[FEdges[J].B] > Dist[FEdges[J].A] + FEdges[J].Weight) Then
            Begin
                Dist[FEdges[J].B] := Dist[FEdges[J].A] + FEdges[J].Weight;
                From[FEdges[J].B] := FEdges[J].A;
            End;
        Path := TList<Integer>.Create();
        I := FinshPoint;
    While I <> -1 Do
    Begin
        Path.Add(I);
        I := From[I];
    End;
    If (Path.Count = 1) And (Path[0] = FinshPoint) Then
        Path.Clear
    Else
        Path.Reverse;
    FindMinPath := Path.ToArray;
End;

Procedure TuVCLFindPath.FormCreate(Sender: TObject);
Begin
    BufferHandler := TBufferHandler.Create();
End;

Procedure TuVCLFindPath.FormDestroy(Sender: TObject);
Begin
    BufferHandler.Destroy();
    BufferHandler := Nil;
End;

End.
