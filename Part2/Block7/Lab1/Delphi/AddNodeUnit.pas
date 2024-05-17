Unit AddNodeUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BufferHandler;

Type
    TuVCLAddNode = Class(TForm)
    LbFormInfo: TLabel;
    LbPairNodeInfo: TLabel;
    LbMainNodeInfo: TLabel;
        EdPairNode: TEdit;
        EdMainNode: TEdit;
        BtnAdd: TButton;
        Procedure FormCreate(Sender: TObject);
        Procedure BtnAddClick(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure EdPairNodeChange(Sender: TObject);
        Procedure EdMainNodeChange(Sender: TObject);
    Private
        FMainNode: Integer;
        FPairNode: Integer;
        BufferHandler: TBufferHandler;
    Public
        Property MainNode: Integer Read FMainNode;
        Property PairNode: Integer Read FPairNode;
    End;

Var
    UVCLAddNode: TuVCLAddNode;

Implementation

{$R *.dfm}

Procedure TuVCLAddNode.BtnAddClick(Sender: TObject);
Const
    MIN: UInt32 = 1;
    MAX: UInt32 = 15;
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
    If BtnAdd.ModalResult = MrNone Then
    Begin
        BtnAdd.ModalResult := MrOk;
        BtnAdd.Click;
    End
    Else
    Begin
        FMainNode := StrToInt(EdMainNode.Text);
        FPairNode := StrToInt(EdPairNode.Text);
    End;
End;

Procedure TuVCLAddNode.EdMainNodeChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdMainNode.Text;
    BufferHandler.DeleteLeadingZeros(TpUInteger);
    EdMainNode.Text := BufferHandler.EditText;
    BtnAdd.Enabled := Not String.IsNullOrEmpty(EdPairNode.Text) And
        Not String.IsNullOrEmpty(EdMainNode.Text);
End;

Procedure TuVCLAddNode.EdPairNodeChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdPairNode.Text;
    BufferHandler.DeleteLeadingZeros(TpUInteger);
    EdPairNode.Text := BufferHandler.EditText;
    BtnAdd.Enabled := Not String.IsNullOrEmpty(EdPairNode.Text) And
        Not String.IsNullOrEmpty(EdMainNode.Text);
End;

Procedure TuVCLAddNode.FormCreate(Sender: TObject);
Begin
    FMainNode := -1;
    FPairNode := -1;
    BufferHandler := TBufferHandler.Create();
End;

Procedure TuVCLAddNode.FormDestroy(Sender: TObject);
Begin
    BufferHandler.Destroy;
    BufferHandler := Nil;
End;

End.
