Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Buttons,
    Backend, AboutTheDeveloperUnit6_2, ExitUnit6_2, InstructionUnit6_2,
    Vcl.Menus;

Type
    TPartOfSquare = (PSLeft, PSTop, PSRight, PSBottom, PSNone);

    TuVCLMain = Class(TForm)
        LbInfo: TLabel;
        ESize: TEdit;
        LbSizeInfo: TLabel;
        StrGrSquare: TStringGrid;
        BitBtnAccept: TBitBtn;
        BitBtnNext: TBitBtn;
        MainMenu1: TMainMenu;
        BtFile: TMenuItem;
        BtOpenFile: TMenuItem;
        BtSaveFile: TMenuItem;
        BtInstruction: TMenuItem;
        BtAboutTheDeveloper: TMenuItem;
        SaveDialog1: TSaveDialog;
        OpenDialog1: TOpenDialog;
        Procedure ESizeKeyPress(Sender: TObject; Var Key: Char);
        Procedure ESizeChange(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure BitBtnAcceptClick(Sender: TObject);
        Procedure BitBtnNextClick(Sender: TObject);
        Procedure BtAboutTheDeveloperClick(Sender: TObject);
        Procedure BtInstructionClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    procedure btOpenFileClick(Sender: TObject);
    procedure btSaveFileClick(Sender: TObject);
    Private
        BufferHandler: TBufferHandler;
        WasChanges: Boolean;
        Size: Integer;
        HighSize: Integer;
        PartOfSquare: TPartOfSquare;
        Offset: Integer;
        WasSaved: Boolean;
        Procedure PrintLeftPartOfSquare();
        Procedure PrintTopPartOfSquare();
        Procedure PrintRightPartOfSquare();
        Procedure PrintBottomPartOfSssquare();
    Public
        { Public declarations }
    End;

Var
    UVCLMain: TuVCLMain;

Implementation

{$R *.dfm}

Procedure TuVCLMain.BitBtnAcceptClick(Sender: TObject);
Var
    I, J, Step1, Step2: Integer;
    Number: Integer;
Begin
    // выставление нужных нам параметров
    Size := StrToInt(ESize.Text);
    Offset := Size Div 2;
    HighSize := Size * 2 - 1;
    // создание квадрата
    StrGrSquare.ColCount := HighSize;
    StrGrSquare.RowCount := HighSize;
    StrGrSquare.Left := (UVCLMain.Width - StrGrSquare.DefaultColWidth *
        StrGrSquare.ColCount) Div 2;
    StrGrSquare.Top := (UVCLMain.Height - StrGrSquare.DefaultRowHeight *
        StrGrSquare.RowCount) Div 2;
    StrGrSquare.Height := (StrGrSquare.DefaultRowHeight + 2) *
        StrGrSquare.ColCount;
    StrGrSquare.Width := (StrGrSquare.DefaultColWidth + 2) *
        StrGrSquare.RowCount;
    // показываем
    StrGrSquare.Visible := True;
    StrGrSquare.Enabled := True;
    J := 0;
    Number := 1;
    For Step1 := Size To HighSize Do
    Begin
        I := Step1 - 1;
        For Step2 := 1 To Size Do
        Begin
            StrGrSquare.Cells[J, I] := IntToStr(Number);
            Inc(Number);
            Inc(J);
            Dec(I);
        End;
        Dec(J, Size - 1);
    End;
    // и включаем кнопку следующий шаг
    BitBtnNext.Visible := True;
    BitBtnNext.Enabled := True;
End;

Procedure TuVCLMain.BitBtnNextClick(Sender: TObject);
Begin
    Case PartOfSquare Of
        PSLeft:
            PrintLeftPartOfSquare();
        PSTop:
            PrintTopPartOfSquare();
        PSRight:
            PrintRightPartOfSquare();
        PSBottom:
            PrintBottomPartOfSssquare();
    End;
    If PartOfSquare < PSNone Then
        PartOfSquare := Succ(PartOfSquare);
    If PartOfSquare = PSNone Then
    Begin
        BitBtnNext.Visible := False;
        BitBtnNext.Enabled := False;
        BtSaveFile.Enabled := True;
    End;
End;

Procedure TuVCLMain.BtAboutTheDeveloperClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLAboutTheDeveloper, UVCLAboutTheDeveloper);
    UVCLAboutTheDeveloper.ShowModal();
    UVCLAboutTheDeveloper.Destroy();
    UVCLAboutTheDeveloper := Nil;
End;

Procedure TuVCLMain.BtInstructionClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLInstruction, UVCLInstruction);
    UVCLInstruction.ShowModal();
    UVCLInstruction.Destroy();
    UVCLInstruction := Nil;
End;

procedure TuVCLMain.btOpenFileClick(Sender: TObject);
Var
    FileReader : TFileReader;
begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create();
        FileReader.FileName := OpenDialog1.FileName;
        FileReader.CheckFile();
        // TODO статусы
        If FileReader.Status = FsGood Then
        Begin
            Size := FileReader.ReadSize();
            If (FileReader.Status = FsGood) Then
            Begin
                ESize.Text := IntToStr(Size);
            End
            Else
                MessageBox(UVCLMain.Handle, ListOfMessages[FileReader.Status],
                    'Ой-йой', MB_ICONERROR);
        End
        Else
            MessageBox(UVCLMain.Handle, ListOfMessages[FileReader.Status],
                'Ой-йой', MB_ICONERROR);
    End;
end;

procedure TuVCLMain.btSaveFileClick(Sender: TObject);
Var
    FileWriter: TFileWriter;
    Matrix : TMatrix;
    I,J: Integer;
Begin
    If SaveDialog1.Execute() Then
    Begin
        FileWriter := TFileWriter.Create();
        FileWriter.FileName := SaveDialog1.FileName;
        FileWriter.CheckFile();
        If FileWriter.Status = FsGood Then
        Begin
            // reading matrix
            SetLength(Matrix,Size,Size);
            for I := 0 to High(Matrix) do
                for J := 0 to High(Matrix[0]) do
                    Matrix[I][J] := StrToInt(StrGrSquare.Cells[J + offset,I + offset]);
            // writing matrix
            FileWriter.WriteList(Matrix);
            If FileWriter.Status <> FsGood Then
            Begin
                MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                    'Ой-йой', MB_ICONERROR);
            End
            Else
                WasSaved := True;
        End
        Else
            MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                'Ой-йой', MB_ICONERROR);
        FileWriter.Destroy();
    End;
end;

Procedure TuVCLMain.ESizeChange(Sender: TObject);
Const
    Min: Integer = 3;
    Max: Integer = 9;
Var
    I, J: Integer;
    SizeEdit: TEdit;
    TempStr: String;
Begin
    SizeEdit := TEdit(Sender);
    BitBtnAccept.Enabled := Not String.IsNullOrEmpty(SizeEdit.Text);
    // проверка на вставку
    BufferHandler.EditText := SizeEdit.Text;
    If Not BufferHandler.CheckInput(TpInteger) Then
    Begin
        MessageBox(UVCLMain.Handle, 'Вы ввели неправильные смиволы!', 'Ой-йой',
            MB_ICONERROR);
        SizeEdit.Text := '';
    End;
    // ведущие 0
    BufferHandler.DeleteLeadingZeros(TpInteger);
    SizeEdit.Text := BufferHandler.EditText;
    If (SizeEdit.Text <> '') And Not BufferHandler.CheckRange(Min, Max,
        TpInteger) Then
    Begin
        MessageBox(UVCLMain.Handle, 'Число не в диапазоне!', 'Ой-йой',
            MB_ICONERROR);
        SizeEdit.Text := '';
    End;
    // проверка на нечетность
    If (SizeEdit.Text <> '') And Not BufferHandler.IsOdd() Then
    Begin
        MessageBox(UVCLMain.Handle, 'Ну я же просил нечётное число!', 'Ой-йой',
            MB_ICONERROR);
        SizeEdit.Text := '';
    End;
    If Not BitBtnAccept.Enabled Then
    Begin
        StrGrSquare.Visible := False;
        StrGrSquare.Enabled := False;
    End;
    If WasChanges Then
    Begin
        // Очистка всех ячеек First Square
        For I := 1 To StrGrSquare.RowCount Do
        Begin
            For J := 1 To StrGrSquare.ColCount Do
            Begin
                StrGrSquare.Cells[J - 1, I - 1] := '';
            End;
        End;
        StrGrSquare.Visible := False;
        StrGrSquare.Enabled := False;
        PartOfSquare := PSLeft;
        BtSaveFile.Enabled := False;
    End;
    WasChanges := True;
End;

Procedure TuVCLMain.ESizeKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = [#03, // ctrl+c
    #08, // backspace
    #22, // ctrl+V
    #24, // ctrl+X
    '1' .. '9' // digits
        ];
    MAX_DIGITS: Integer = 1;
Var
    SizeEdit: TEdit;
    TempKey: Char;
Begin
    SizeEdit := TEdit(Sender);
    If (Length(SizeEdit.Text) = 0) And Not(Key In GOOD_KEYS) Then
        Key := #0;
    If (Length(SizeEdit.Text) > 0) And
        Not((Key In GOOD_KEYS) Or (Key = '0')) Then
        Key := #0;
    If (SizeEdit.SelLength > 0) And Not((Key In GOOD_KEYS) Or (Key = '0')) Then
        Key := #0;
    If (Length(SizeEdit.Text) > MAX_DIGITS) And (Key <> #08) And
        (SizeEdit.SelLength = 0) Then
        Key := #0;
End;

Procedure TuVCLMain.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Not StrGrSquare.Enabled Or WasSaved Then
    Begin
        Application.CreateForm(TuVCLExit, UVCLExit);
        UVCLExit.ShowModal;
        If UVCLExit.GetStatus() Then
            CanClose := True;
        UVCLExit.Destroy();
        UVCLExit := Nil;
    End
    else
    Begin
        Repeat
            ExitCode := MessageBox(UVCLMain.Handle,
                'Сохранить данные в файл перед выходом?', 'Подверждение',
                MB_ICONQUESTION + MB_YESNOCANCEL);
            If ExitCode = ID_YES Then
            Begin
                BtSaveFileClick(UVCLMain);
                CanClose := True;
            End
            Else If ExitCode = ID_NO Then
                CanClose := True
            Else
                CanClose := False;
        Until WasSaved Or (ExitCode = ID_NO) Or (ExitCode = ID_CANCEL);
    End;

End;

Procedure TuVCLMain.FormCreate(Sender: TObject);
Begin
    BufferHandler := TBufferHandler.Create();
End;

Procedure TuVCLMain.PrintBottomPartOfSssquare;
Var
    I, J, K: Integer;
Begin
    K := Offset + 1;
    While K < Offset + Size - 1 Do
    Begin
        I := HighSize - Offset;
        J := K;
        While (I < HighSize) And (StrGrSquare.Cells[J, I] <> '') Do
        Begin
            StrGrSquare.Cells[J, I - Size] := StrGrSquare.Cells[J, I];
            StrGrSquare.Cells[J, I] := '';
            Inc(J);
            Inc(I);
        End;
        Inc(K, 2);
    End;
End;

Procedure TuVCLMain.PrintLeftPartOfSquare;
Var
    I, J, K: Integer;
Begin
    K := Offset + 1;
    While K < Offset + Size - 1 Do
    Begin
        I := K;
        J := Offset - 1;
        While (J > -1) And (StrGrSquare.Cells[J, I] <> '') Do
        Begin
            StrGrSquare.Cells[J + Size, I] := StrGrSquare.Cells[J, I];
            StrGrSquare.Cells[J, I] := '';
            Dec(J);
            Inc(I);
        End;
        Inc(K, 2)
    End;
End;

Procedure TuVCLMain.PrintRightPartOfSquare;
Var
    I, J, K: Integer;
Begin
    K := Offset + 1;
    While K < Offset + Size - 1 Do
    Begin
        I := K;
        J := HighSize - Offset;
        While (J < HighSize) And (StrGrSquare.Cells[J, I] <> '') Do
        Begin
            StrGrSquare.Cells[J - Size, I] := StrGrSquare.Cells[J, I];
            StrGrSquare.Cells[J, I] := '';
            Inc(I);
            Inc(J);
        End;
        Inc(K, 2);
    End;
End;

Procedure TuVCLMain.PrintTopPartOfSquare;
Var
    I, J, K: Integer;
Begin
    K := Offset + 1;
    While K < Offset + Size - 1 Do
    Begin
        I := Offset - 1;
        J := K;
        While (I > -1) And (StrGrSquare.Cells[J, I] <> '') Do
        Begin
            StrGrSquare.Cells[J, I + Size] := StrGrSquare.Cells[J, I];
            StrGrSquare.Cells[J, I] := '';
            Dec(I);
            Inc(J);
        End;
        Inc(K, 2);
    End;
End;

End.
