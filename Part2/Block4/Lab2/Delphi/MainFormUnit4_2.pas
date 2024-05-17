Unit MainFormUnit4_2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, System.ImageList,
    Vcl.ImgList, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus,
    InstructionUnit4_2, AboutTheDeveloperUnit4_2, BackendUnit4_2,
    OutputSortedArrayUnit4_2, ExitUnit4_2;

Type
    // форма
    TuVCLMain = Class(TForm)
    lbTaskInfo: TLabel;
    lbSizeInfo: TLabel;
    eSize: TEdit;
    bitBtAcceptSize: TButton;
    strGrElementsOfArray: TStringGrid;
        ImageList1: TImageList;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        MainMenu1: TMainMenu;
    btFile: TMenuItem;
    btOpenFile: TMenuItem;
    btSaveFile: TMenuItem;
    btInstruction: TMenuItem;
    btAboutTheDeveloper: TMenuItem;
    lbElementsInfo: TLabel;
    bitBtSortArray: TBitBtn;
    bitBtShowList: TBitBtn;
        Procedure eSizeKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure eSizeKeyPress(Sender: TObject; Var Key: Char);
        Procedure btInstructionClick(Sender: TObject);
        Procedure btAboutTheDeveloperClick(Sender: TObject);
        Procedure eSizeChange(Sender: TObject);
        Procedure strGrElementsOfArrayKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure bitBtAcceptSizeClick(Sender: TObject);
        Procedure strGrElementsOfArrayKeyPress(Sender: TObject; Var Key: Char);
        Procedure bitBtSortArrayClick(Sender: TObject);
        Procedure bitBtShowListClick(Sender: TObject);
        Procedure btOpenFileClick(Sender: TObject);
        Procedure btSaveFileClick(Sender: TObject);

        Procedure strGrElementsOfArrayKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure bitBtSortArrayKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Function FormHelp(Command: Word; Data: NativeInt;
            Var CallHelp: Boolean): Boolean;
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
    Private
        Size: Integer;
        IsFileSaved: Boolean;
        IsArrayFilled: Boolean;
        IsSortButtonPressed: Boolean;
        WasChanges: Boolean;
        BufferHandler: TBufferHandler;
    Public
        { Public declarations }
    End;

Var
    uVCLMain: TuVCLMain;

Implementation

{$R *.dfm}

Procedure TuVCLMain.btAboutTheDeveloperClick(Sender: TObject);
Begin
    uVCLAboutTheDeveloper.Show;
End;

Procedure TuVCLMain.btInstructionClick(Sender: TObject);
Begin
    uVCLInstruction.Show;
End;

Procedure TuVCLMain.btOpenFileClick(Sender: TObject);
Var
    FileReader: TFileReader;
    I: Integer;
    Arr: TArray;
Begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create;
        FileReader.SetFileName(OpenDialog1.FileName);
        If FileReader.IsFileGood() Then
        Begin
            Size := FileReader.InputSize();
            If FileReader.GetStatus() Then
            Begin
                eSize.Text := IntToStr(Size);
                bitBtAcceptSize.Click;
                Arr := FileReader.InputArray(Size);
                If FileReader.GetStatus() Then
                Begin
                    For I := 1 To Size Do
                    Begin
                        strGrElementsOfArray.Cells[I, 1] := IntToStr(Arr[I - 1]);
                        ArraySorter.SetElementByIndex(Arr[I - 1], I - 1);
                    End;
                    bitbtSortArray.Enabled := True;
                End
                Else
                    MessageBox(uVCLMain.Handle,
                        'Элементы массива введены неправильно! Проверьте данные.',
                        'Ой-йой', MB_ICONERROR)
            End
            Else
                MessageBox(uVCLMain.Handle,
                    'Размер введён неправильно или не соответствует границам! Проверьте данные.',
                    'Ой-йой', MB_ICONERROR);
        End
        Else
            MessageBox(uVCLMain.Handle,
                'Файл закрыт для чтения или не текстовый! ', 'Ошибка',
                MB_ICONERROR);
        If Not FileReader.GetStatus() Then
        Begin
            eSize.Text := '';
            BitbtAcceptSize.Enabled := False;
            strGrElementsOfArray.Enabled := False;
            strGrElementsOfArray.Visible := False;
        End;
        FileReader.Destroy;
        FileReader := Nil;
    End;
End;

Procedure TuVCLMain.btSaveFileClick(Sender: TObject);
Var
    FileWriter: TFileWriter;
Begin
    If SaveDialog1.Execute() Then
    Begin
        FileWriter := TFileWriter.Create;
        FileWriter.SetFileName(SaveDialog1.FileName);
        If FileWriter.IsFileGood() Then
        Begin
            FileWriter.OutputArray(ArraySorter.GetArray(), Size);
            If FileWriter.GetStatus() Then
                IsFileSaved := True
            Else
                MessageBox(uVCLMain.Handle, 'Упс.. Что-то пошло не так!',
                    'Ой-йой', MB_ICONERROR);
        End
        Else
            MessageBox(uVCLMain.Handle,
                'Файл закрыт для записи или не текстовый!', 'Ой-йой',
                MB_ICONERROR);
        FileWriter.Destroy;
        FileWriter := Nil;
    End;
End;

Procedure TuVCLMain.bitBtShowListClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLOutputSortedArray, uVCLOutputSortedArray);
    uVCLOutputSortedArray.ShowModal;
    uVCLOutputSortedArray.Destroy;
    uVCLOutputSortedArray := Nil;
End;

Procedure TuVCLMain.bitBtAcceptSizeClick(Sender: TObject);
Const
    MAX_SIZE: Integer = 1000;
    MIN_SIZE: Integer = 0;
Var
    I: Integer;
Begin
    // creating Grid
    Size := StrToInt(eSize.Text);
    If WasChanges Then
    Begin
        If (MIN_SIZE < Size) And (Size < MAX_SIZE) Then
        Begin
            If ArraySorter <> Nil Then
                ArraySorter.Destroy();
            ArraySorter := TArraySorter.Create(Size);
            strGrElementsOfArray.RowCount := 2;
            strGrElementsOfArray.ColCount := Size + 1;
            strGrElementsOfArray.FixedCols := 1;
            strGrElementsOfArray.FixedRows := 1;
            strGrElementsOfArray.Cells[0, 0] := '№';
            strGrElementsOfArray.Cells[0, 1] := 'Элемент';
            For I := 1 To Size Do
            Begin
                strGrElementsOfArray.Cells[I, 0] := IntToStr(I);
                strGrElementsOfArray.Cells[I, 1] := '';
            End;
            strGrElementsOfArray.Enabled := True;
            lbElementsInfo.Visible := True;
            strGrElementsOfArray.Visible := True;
            bitBtSortArray.Visible := True;
            bitBtShowList.Visible := True;
            bitBtAcceptSize.Enabled := False;
            ActiveControl := strGrElementsOfArray;
        End
        Else
            MessageBox(uVCLMain.Handle,
                'Размер не соответствует границам! Проверьте данные.', 'Ой-йой',
                MB_ICONERROR);
    End;
    WasChanges := False;
End;

Procedure TuVCLMain.eSizeChange(Sender: TObject);
Var
    I, J: Integer;
    SizeEdit: TEdit;
    TempStr: String;
Begin
    SizeEdit := TEdit(Sender);
    BitbtAcceptSize.Enabled := Not String.IsNullOrEmpty(SizeEdit.Text);
    // проверка на вставку
    BufferHandler.EditText := SizeEdit.Text;
    If Not BufferHandler.Status Then
    Begin
        MessageBox(uVCLMain.Handle, 'Вы ввели неправильные смиволы!', 'Ой-йой',
            MB_ICONERROR);
        SizeEdit.Text := '';
    End;
    // ведущие 0
    While (Length(SizeEdit.Text) > 0) And (SizeEdit.Text[1] = '0') Do
    Begin
        TempStr := SizeEdit.Text;
        Delete(TempStr, 1, 1);
        SizeEdit.Text := TempStr;
    End;
    If Not bitBtAcceptSize.Enabled Then
    Begin
        StrGrElementsOfArray.Enabled := False;
    End;
    If WasChanges Then
    Begin
        // Очистка всех ячеек StringGrid
        For I := 1 To StrGrElementsOfArray.RowCount Do
        Begin
            For J := 1 To StrGrElementsOfArray.ColCount Do
            Begin
                StrGrElementsOfArray.Cells[J - 1, I - 1] := '';
            End;
        End;
        IsArrayFilled := False;
        LbElementsInfo.Visible := False;
        StrGrElementsOfArray.Visible := False;
        BitBtSortArray.Visible := False;
        BitBtShowList.Visible := False;
        BitBtSortArray.Enabled := False;
        BitBtShowList.Enabled := False;
        BtSaveFile.Enabled := False;
    End;
    WasChanges := True;
End;

Procedure TuVCLMain.eSizeKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    // when user change size
    If (BitbtAcceptSize.Enabled) And (eSize.SelLength = 0) And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := BitbtAcceptSize;
    If (BitbtAcceptSize.Enabled) And (eSize.SelStart = Length(eSize.Text)) And
        ((Key = VK_RIGHT)) Then
        ActiveControl := BitbtAcceptSize;
    If (BitBtShowList.Enabled) And ((Key = VK_UP) Or (Key = VK_LEFT)) Then
        ActiveControl :=BitBtShowList;
    // when user's already pressed sizeButton
    If Not BitbtAcceptSize.Enabled And StrGrElementsOfArray.Enabled And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := StrGrElementsOfArray;
    If Not BitbtAcceptSize.Enabled And StrGrElementsOfArray.Enabled And
        (eSize.SelStart = Length(eSize.Text)) And ((Key = VK_RIGHT)) Then
        ActiveControl := StrGrElementsOfArray;
End;

Procedure TuVCLMain.eSizeKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = [
    #03, // ctrl+c
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
    // old version
    { If (Length(SizeEdit.Text) = 0) And Not(Key In GOOD_KEYS) Then
      Key := #0;
      If (Length(SizeEdit.Text) > 0) And
      Not((Key In GOOD_KEYS) Or (Key = '0')) Then
      Key := #0;
      If (Length(SizeEdit.Text) > 1) And (SizeEdit.SelStart = 1) And
      (SizeEdit.Text[2] = '0') And (Key = #08) Then
      Key := #0;
      // for backspace
      If (Length(SizeEdit.Text) > 1) And
      (Length(SizeEdit.Text) <> SizeEdit.SelLength) And
      (SizeEdit.SelLength <> 0) And (SizeEdit.SelStart = 0) And
      (SizeEdit.Text[SizeEdit.SelLength + 1] = '0') And
      Not(Key In ['1' .. '9']) Then
      Key := #0;
      If (SizeEdit.SelStart = 0) And (Key = '0') Then
      Key := #0;
      // Key := 0;
      If (Length(SizeEdit.Text) > MAX_DIGITS) And (Key <> #08) And
      (SizeEdit.SelLength = 0) Then
      Key := #0; }
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

Procedure TuVCLMain.bitBtSortArrayClick(Sender: TObject);
Var
    UserArray: TArray;
Begin
    UserArray := ArraySorter.GetUserArray();
    ArraySorter.QuickSort(UserArray, 0, High(UserArray));
    bitbtShowList.Enabled := True;
    btSaveFile.Enabled := True;
    IsFileSaved := False;
    IsSortButtonPressed := True;
End;

Procedure TuVCLMain.bitBtSortArrayKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (bitBtShowList.Enabled) And ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := BitBtShowList;
    If (Key = VK_UP) Then
        ActiveControl := StrGrElementsOfArray;
End;

Procedure TuVCLMain.strGrElementsOfArrayKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    BitBtShowList.Enabled := False;
    IsSortButtonPressed := False;
    BtSaveFile.Enabled := False;
    IsFileSaved := False;
    If Key = VK_UP Then
        ActiveControl := eSize;
    If (BitBtSortArray.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := BitBtSortArray
    Else If Not(BitBtSortArray.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := eSize;
    If (BitBtSortArray.Enabled) And (IsArrayFilled) And (Key = VK_RETURN) Then
        ActiveControl := BitBtSortArray;
End;

Procedure TuVCLMain.strGrElementsOfArrayKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['0' .. '9'];
    MAX_DIGITS: Integer = 4;
Var
    ArrGrid: TStringGrid;
    TempNumber: String;
Begin
    ArrGrid := TStringGrid(Sender);
    TempNumber := ArrGrid.Cells[ArrGrid.Col, 1];
    If (Length(TempNumber) = 1) And (TempNumber = '0') And (Key <> #08) Then
        Key := #0;
    If (Key = #08) And (Length(ArrGrid.Cells[ArrGrid.Col, 1]) <> 0) Then
    Begin
        Delete(TempNumber, Length(TempNumber), 1);
        ArrGrid.Cells[ArrGrid.Col, 1] := TempNumber;
    End;
    If (Key <> #0) And (Length(TempNumber) = 0) And (Key = '-') Then
        ArrGrid.Cells[ArrGrid.Col, 1] := ArrGrid.Cells[ArrGrid.Col, 1] + Key;
    If (Length(TempNumber) = 1) And (TempNumber = '-') And (Key = '0') Then
        Key := #0;
    If (Key <> #0) And (Pos('-', TempNumber) = 0) And (Key In GOOD_KEYS) And
        (Length(TempNumber) < MAX_DIGITS) Then
        ArrGrid.Cells[ArrGrid.Col, 1] := ArrGrid.Cells[ArrGrid.Col, 1] + Key;
    If (Key <> #0) And (Pos('-', TempNumber) = 1) And (Key In GOOD_KEYS) And
        (Length(TempNumber) < MAX_DIGITS + 1) Then
        ArrGrid.Cells[ArrGrid.Col, 1] := ArrGrid.Cells[ArrGrid.Col, 1] + Key;
    If (Key <> #0) And (Pos('-', TempNumber) = 1) And (Key = '0') Then
        Key := #0;
    If (Key = #13) And (ArrGrid.Col < ArrGrid.ColCount - 1) Then
        ArrGrid.Col := ArrGrid.Col + 1;
End;

Procedure TuVCLMain.strGrElementsOfArrayKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Counter, I: Integer;
Begin
    Counter := 0;
    For I := 1 To Size Do
    Begin
        If (Length(strGrElementsOfArray.Cells[I, 1]) <> 0) And
            (strGrElementsOfArray.Cells[I, 1] <> '-') Then
        Begin
            ArraySorter.SetElementByIndex
                (StrToInt(strGrElementsOfArray.Cells[I, 1]), I - 1);
            Inc(Counter);
        End;
    End;
    If Counter = Size Then
        IsArrayFilled := True
    Else
        IsArrayFilled := False;
    bitBtSortArray.Enabled := IsArrayFilled;
End;

Procedure TuVCLMain.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Not IsSortButtonPressed Or IsFileSaved Then
    Begin
        Application.CreateForm(TuVCLExit, uVCLExit);
        uVCLExit.ShowModal;
        CanClose := uVCLExit.GetStatus();
        uVCLExit.Destroy();
    End
    Else If IsSortButtonPressed Then
    Begin
        Repeat
            ExitCode := MessageBox(uVCLMain.Handle,
                'Сохранить данные в файл перед выходом?', 'Подверждение',
                MB_ICONQUESTION + MB_YESNOCANCEL);
            If ExitCode = ID_YES Then
            Begin
                BtSaveFileClick(uVCLMain);
                CanClose := True;
            End
            Else If ExitCode = ID_NO Then
                CanClose := True
            Else
                CanClose := False;
        Until IsFileSaved Or (ExitCode = ID_NO) Or (ExitCode = ID_CANCEL);
    End;
End;

Procedure TuVCLMain.FormCreate(Sender: TObject);
Begin
    BufferHandler := TBufferHandler.Create();
End;

Procedure TuVCLMain.FormDestroy(Sender: TObject);
Begin
    BufferHandler.Destroy();
End;

Function TuVCLMain.FormHelp(Command: Word; Data: NativeInt;
    Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
End;

End.
