Unit UnitDeleter;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UnitBackend, Vcl.Buttons;

Type
    TuVCLDeleter = Class(TForm)
        LbDeleterInfo: TLabel;
        ENumberOfWorker: TEdit;
    BitbtDelete: TBitBtn;
        Procedure ENumberOfWorkerChange(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eNumberOfWorkerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitbtDeleteClick(Sender: TObject);
    Private
        FBufferHandler: TBufferHandler;
        FIsChosen: Boolean;
        FCountOfWorkers: Integer;
    Public
        Property IsChosen: Boolean Read FIsChosen;
        Property CountOfWorkers: Integer Write FCountOfWorkers;
    End;

Var
    uVCLDeleter: TuVCLDeleter;

Implementation

{$R *.dfm}

procedure TuVCLDeleter.BitbtDeleteClick(Sender: TObject);
begin
    If (StrToInt(ENumberOfWorker.Text) < (FCountOfWorkers + 1)) Then
    Begin
        FIsChosen := True;
        BitbtDelete.Enabled := False;
        MessageBox(uVCLDeleter.Handle, 'Работник удален успешно!', 'Удаление',
            MB_OK);
        Self.Close();
    End
    else
        MessageBox(uVCLDeleter.Handle, 'Вы ввели номер несуществуюещего работника!', 'Ой-йой',
            MB_ICONERROR);
end;

Procedure TuVCLDeleter.ENumberOfWorkerChange(Sender: TObject);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    FBufferHandler.EditText := CurEdit.Text;
    If Not FBufferHandler.CheckInput(TpUInteger) Then
    Begin
        MessageBox(uVCLDeleter.Handle, 'Вы ввели неправильные смиволы!', 'Ой-йой',
            MB_ICONERROR);
        CurEdit.Text := '';
    End;
    FBufferHandler.DeleteLeadingZeros(TpInteger);
    CurEdit.Text := FBufferHandler.EditText;
    BitbtDelete.Enabled := Not String.IsNullOrEmpty(CurEdit.Text);
End;

procedure TuVCLDeleter.eNumberOfWorkerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = VK_RIGHT) Or (Key = VK_LEFT) or (Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_RETURN) then
        ActiveControl := BitbtDelete;
end;

Procedure TuVCLDeleter.FormCreate(Sender: TObject);
Begin
    FBufferHandler := TBufferHandler.Create();
    FIsChosen := False;
End;

procedure TuVCLDeleter.FormDestroy(Sender: TObject);
begin
    FBufferHandler.Destroy();
end;

End.
