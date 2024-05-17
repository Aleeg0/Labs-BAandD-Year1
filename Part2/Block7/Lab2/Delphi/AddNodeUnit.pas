Unit AddNodeUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BufferHandler, EdgeUnit;

Type
    TuVCLAddNode = Class(TForm)
        LbFormInfo: TLabel;
        LbPairNodeInfo: TLabel;
        LbMainNodeInfo: TLabel;
        EdPairNode: TEdit;
        EdMainNode: TEdit;
        BtnAdd: TButton;
        LbWeightInfo: TLabel;
        EdWeight: TEdit;
        Procedure FormCreate(Sender: TObject);
        Procedure BtnAddClick(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure EdPairNodeChange(Sender: TObject);
        Procedure EdMainNodeChange(Sender: TObject);
        Procedure EdWeightChange(Sender: TObject);
    Private
        BufferHandler: TBufferHandler;
        FEdge: TEdge;
    Public
        Property Edge: TEdge Read FEdge;
    End;

Var
    UVCLAddNode: TuVCLAddNode;

Implementation

{$R *.dfm}

Procedure TuVCLAddNode.BtnAddClick(Sender: TObject);
Const
    MIN: UInt32 = 1;
    MAX: UInt32 = 15;
    WEIGHT_MIN: Integer = -99;
    WEIGHT_MAX: Integer = 99;
Begin
    BufferHandler.EditText := EdMainNode.Text;
    If Not BufferHandler.CheckInput(TpUInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверный тип вершины. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    If Not BufferHandler.CheckRange(MIN, MAX, TpUInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверные границы. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    BufferHandler.EditText := EdPairNode.Text;
    If Not BufferHandler.CheckInput(TpUInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверный тип вершины. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    If Not BufferHandler.CheckRange(MIN, MAX, TpUInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверные границы. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    BufferHandler.EditText := EdWeight.Text;
    If Not BufferHandler.CheckInput(TpInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверный тип вершины. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    If Not BufferHandler.CheckRange(WEIGHT_MIN, WEIGHT_MAX, TpInteger) Then
    Begin
        MessageBox(Self.Handle, 'Неверные границы. Повторите ещё раз!',
            'Ошибочка', MB_ICONWARNING);
        Exit();
    End;
    If BtnAdd.ModalResult = MrNone Then
    Begin
        BtnAdd.ModalResult := MrOk;
        BtnAdd.Click;
    End
    Else
    Begin
        FEdge.A := StrToInt(EdMainNode.Text) - 1;
        FEdge.B := StrToInt(EdPairNode.Text) - 1;
        FEdge.Weight := StrToInt(EdWeight.Text);
    End;
End;

Procedure TuVCLAddNode.EdMainNodeChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdMainNode.Text;
    BufferHandler.DeleteLeadingZeros(TpUInteger);
    EdMainNode.Text := BufferHandler.EditText;
    BtnAdd.Enabled := Not String.IsNullOrEmpty(EdPairNode.Text) And
        Not String.IsNullOrEmpty(EdMainNode.Text) And
        Not String.IsNullOrEmpty(EdWeight.Text);
End;

Procedure TuVCLAddNode.EdPairNodeChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdPairNode.Text;
    BufferHandler.DeleteLeadingZeros(TpUInteger);
    EdPairNode.Text := BufferHandler.EditText;
    BtnAdd.Enabled := Not String.IsNullOrEmpty(EdPairNode.Text) And
        Not String.IsNullOrEmpty(EdMainNode.Text) And
        Not String.IsNullOrEmpty(EdWeight.Text);
End;

Procedure TuVCLAddNode.EdWeightChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdWeight.Text;
    BufferHandler.DeleteLeadingZeros(TpInteger);
    EdWeight.Text := BufferHandler.EditText;
    BtnAdd.Enabled := Not String.IsNullOrEmpty(EdPairNode.Text) And
        Not String.IsNullOrEmpty(EdMainNode.Text) And
        Not String.IsNullOrEmpty(EdWeight.Text);
End;

Procedure TuVCLAddNode.FormCreate(Sender: TObject);
Begin
    FEdge.A := -1;
    FEdge.B := -1;
    FEdge.Weight := 0;
    BufferHandler := TBufferHandler.Create();
End;

Procedure TuVCLAddNode.FormDestroy(Sender: TObject);
Begin
    BufferHandler.Destroy;
    BufferHandler := Nil;
End;

End.
