Unit DeleteUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BufferHandler, EdgeUnit;

Type
    TuVCLDelete = Class(TForm)
        LbFormInfo: TLabel;
        LbPairNodeInfo: TLabel;
        LbMainNodeInfo: TLabel;
        EdPairNode: TEdit;
        EdMainNode: TEdit;
        BtnDelete: TButton;
        Procedure BtnDeleteClick(Sender: TObject);
        Procedure EdPairNodeChange(Sender: TObject);
        Procedure EdMainNodeChange(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
    Private
        FEdge : TEdge;
        FCount : Integer;
        BufferHandler: TBufferHandler;
    Public
        Property Edge : TEdge Read FEdge;
        Property Count : Integer Write FCount;
    End;

Var
    UVCLDelete: TuVCLDelete;

Implementation

{$R *.dfm}

Procedure TuVCLDelete.BtnDeleteClick(Sender: TObject);
Const
    MIN: UInt32 = 1;
Begin
    BufferHandler.EditText := EdMainNode.Text;
    If Not BufferHandler.CheckInput(TpUInteger) Then
    Begin
        MessageBox(Self.Handle, '�������� ��� �������. ��������� ��� ���!',
            '��������', MB_ICONWARNING);
        Exit();
    End;
    If Not BufferHandler.CheckRange(MIN, FCount, TpUInteger) Then
    Begin
        MessageBox(Self.Handle, '�������� �������. �������� ������� �� ������������ �������. ��������� ��� ���!',
            '��������', MB_ICONWARNING);
        Exit();
    End;
    BufferHandler.EditText := EdPairNode.Text;
    If Not BufferHandler.CheckInput(TpUInteger) Then
    Begin
        MessageBox(Self.Handle, '�������� ��� �������. ��������� ��� ���!',
            '��������', MB_ICONWARNING);
        Exit();
    End;
    If Not BufferHandler.CheckRange(MIN, FCount, TpUInteger) Then
    Begin
        MessageBox(Self.Handle, '�������� �������. �������� ������� �� ������������ �������. ��������� ��� ���!',
            '��������', MB_ICONWARNING);
        Exit();
    End;
    If BtnDelete.ModalResult = MrNone Then
    Begin
        BtnDelete.ModalResult := MrOk;
        BtnDelete.Click;
    End
    Else
    Begin
        FEdge.A := StrToInt(EdMainNode.Text) - 1;
        FEdge.B := StrToInt(EdPairNode.Text) - 1;
    End;
End;

Procedure TuVCLDelete.EdMainNodeChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdMainNode.Text;
    BufferHandler.DeleteLeadingZeros(TpUInteger);
    EdMainNode.Text := BufferHandler.EditText;
    BtnDelete.Enabled := Not String.IsNullOrEmpty(EdPairNode.Text) And
        Not String.IsNullOrEmpty(EdMainNode.Text);
End;

Procedure TuVCLDelete.EdPairNodeChange(Sender: TObject);
Begin
    BufferHandler.EditText := EdPairNode.Text;
    BufferHandler.DeleteLeadingZeros(TpUInteger);
    EdPairNode.Text := BufferHandler.EditText;
    BtnDelete.Enabled := Not String.IsNullOrEmpty(EdPairNode.Text) And
        Not String.IsNullOrEmpty(EdMainNode.Text);
End;

Procedure TuVCLDelete.FormCreate(Sender: TObject);
Begin
    BufferHandler := TBufferHandler.Create();
    FEdge.A := -1;
    FEdge.B := -1;
End;

Procedure TuVCLDelete.FormDestroy(Sender: TObject);
Begin
    BufferHandler.Destroy();
    BufferHandler := Nil;
End;

End.
