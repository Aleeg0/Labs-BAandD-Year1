Unit MainUnit5_2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, System.ImageList,
    Vcl.ImgList, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus,
    InstructionUnit5_2, AboutTheDeveloperUnit5_2, BackendUnit5_2,
    ExitUnit5_2, System.Generics.Collections, OutputUnit5_2;

Type
    // форма
    TuVCLMain = Class(TForm)
        LbTaskInfo: TLabel;
        LbSizeInfo: TLabel;
        ESize: TEdit;
        BitBtAcceptSize: TButton;
        StrGrList: TStringGrid;
        ImageList1: TImageList;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        MainMenu1: TMainMenu;
        BtFile: TMenuItem;
        BtOpenFile: TMenuItem;
        BtSaveFile: TMenuItem;
        BtInstruction: TMenuItem;
        BtAboutTheDeveloper: TMenuItem;
        LbElementsInfo: TLabel;
        BitBtFindRoots: TBitBtn;
        BitBtShowTree: TBitBtn;
        LValuesOfTree: TLabel;
        Procedure ESizeKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure ESizeKeyPress(Sender: TObject; Var Key: Char);
        Procedure BtInstructionClick(Sender: TObject);
        Procedure BtAboutTheDeveloperClick(Sender: TObject);
        Procedure ESizeChange(Sender: TObject);
        Procedure StrGrListKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure BitBtAcceptSizeClick(Sender: TObject);
        Procedure StrGrListKeyPress(Sender: TObject; Var Key: Char);
        Procedure BitBtFindRootsClick(Sender: TObject);
        Procedure BtOpenFileClick(Sender: TObject);
        Procedure BtSaveFileClick(Sender: TObject);

        Procedure StrGrListKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure BitBtFindRootsKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Function FormHelp(Command: Word; Data: NativeInt;
            Var CallHelp: Boolean): Boolean;
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure BitBtShowTreeClick(Sender: TObject);
    Private
        Size: Integer;
        IsFileSaved: Boolean;
        IsArrayFilled: Boolean;
        IsBitBtFindPressed: Boolean;
        WasChanges: Boolean;
        BufferHandler: TBufferHandler;
        ListOfValues: TList<Integer>;
    Public
        { Public declarations }
    End;

Var
    UVCLMain: TuVCLMain;

Implementation

{$R *.dfm}

Procedure TuVCLMain.BtAboutTheDeveloperClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLAboutTheDeveloper, UVCLAboutTheDeveloper);
    UVCLAboutTheDeveloper.Show;
    uVCLAboutTheDeveloper.Destroy();
End;

Procedure TuVCLMain.BtInstructionClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLInstruction, UVCLInstruction);
    UVCLInstruction.ShowModal;
    UVCLInstruction.Destroy;
End;

Procedure TuVCLMain.BtOpenFileClick(Sender: TObject);
Var
    FileReader: TFileReader;
    I: Integer;
    Size: Integer;
    List: TList<Integer>;
    A: Word;
    B: TShiftState;
Begin
    List := TList<Integer>.Create;
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
                BitBtAcceptSize.Click;
                List := FileReader.ReadList(Size);
                If (FileReader.Status = FsGood) Then
                Begin
                    For I := 1 To Size Do
                    Begin
                        StrGrList.Cells[I, 0] := IntToStr(I);
                        StrGrList.Cells[I, 1] := IntToStr(List[I - 1]);
                    End;

                End;
                StrGrListKeyUp(Sender, A, B);
            End
            Else
                MessageBox(UVCLMain.Handle, ListOfMessages[FileReader.Status],
                    'Ой-йой', MB_ICONERROR);
        End
        Else
            MessageBox(UVCLMain.Handle, ListOfMessages[FileReader.Status],
                'Ой-йой', MB_ICONERROR);
    End;
End;

Procedure TuVCLMain.BtSaveFileClick(Sender: TObject);
Var
    FileWriter: TFileWriter;
Begin
    If SaveDialog1.Execute() Then
    Begin
        FileWriter := TFileWriter.Create();
        FileWriter.FileName := SaveDialog1.FileName;
        FileWriter.CheckFile();
        If FileWriter.Status = FsGood Then
        Begin
            FileWriter.WriteList(ListOfValues);
            If FileWriter.Status <> FsGood Then
            Begin
                MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                    'Ой-йой', MB_ICONERROR);
            End
            Else
                IsFileSaved := True;
        End
        Else
            MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                'Ой-йой', MB_ICONERROR);
        FileWriter.Destroy();
    End;
End;

Procedure TuVCLMain.BitBtAcceptSizeClick(Sender: TObject);
Const
    MAX_SIZE: Integer = 1000;
    MIN_SIZE: Integer = 0;
Var
    I: Integer;
Begin
    // creating Grid
    Size := StrToInt(ESize.Text);
    If WasChanges Then
    Begin
        If (MIN_SIZE < Size) And (Size < MAX_SIZE) Then
        Begin
            // list1
            StrGrList.RowCount := 2;
            StrGrList.ColCount := Size + 1;
            StrGrList.FixedCols := 1;
            StrGrList.FixedRows := 1;
            StrGrList.Cells[0, 0] := '№';
            StrGrList.Cells[0, 1] := 'Элемент';
            For I := 1 To Size Do
            Begin
                StrGrList.Cells[I, 0] := IntToStr(I);
                StrGrList.Cells[I, 1] := '';
            End;
            StrGrList.Enabled := True;
            StrGrList.Visible := True;
            BitBtAcceptSize.Enabled := False;
        End
        Else
            MessageBox(UVCLMain.Handle,
                'Размер не соответствует границам! Проверьте данные.', 'Ой-йой',
                MB_ICONERROR);
    End;
    WasChanges := False;
End;

Procedure TuVCLMain.ESizeChange(Sender: TObject);
Const
    Min: Integer = 0;
    Max: Integer = 16;
Var
    I, J: Integer;
    SizeEdit: TEdit;
    TempStr: String;
Begin
    SizeEdit := TEdit(Sender);
    BitBtAcceptSize.Enabled := Not String.IsNullOrEmpty(SizeEdit.Text);
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
    If Not BitBtAcceptSize.Enabled Then
    Begin
        StrGrList.Enabled := False;
    End;
    If WasChanges Then
    Begin
        // Очистка всех ячеек StringGrid
        For I := 1 To StrGrList.RowCount Do
        Begin
            For J := 1 To StrGrList.ColCount Do
            Begin
                StrGrList.Cells[J - 1, I - 1] := '';
            End;
        End;
        StrGrList.Visible := False;
        BitBtFindRoots.Visible := False;
        BitBtShowTree.Visible := False;
        BitBtFindRoots.Enabled := False;
        BitBtShowTree.Enabled := False;
        BtSaveFile.Enabled := False;
        LValuesOfTree.Visible := False;
    End;
    WasChanges := True;
End;

Procedure TuVCLMain.ESizeKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    // when user change size
    If (BitbtAcceptSize.Enabled) And (ESize.SelLength = 0) And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := BitbtAcceptSize;
    If (BitbtAcceptSize.Enabled) And (ESize.SelStart = Length(ESize.Text)) And
        ((Key = VK_RIGHT)) Then
        ActiveControl := BitbtAcceptSize;
    If (BitBtShowTree.Enabled) And ((Key = VK_UP) Or (Key = VK_LEFT)) Then
        ActiveControl := BitBtShowTree;
    // when user's already pressed sizeButton
    If Not BitbtAcceptSize.Enabled And StrGrList.Enabled And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := StrGrList;
    If Not BitbtAcceptSize.Enabled And StrGrList.Enabled And
        (ESize.SelStart = Length(ESize.Text)) And ((Key = VK_RIGHT)) Then
        ActiveControl := StrGrList;
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

Procedure TuVCLMain.BitBtFindRootsClick(Sender: TObject);
Var
    I: Integer;
Begin
    If Tree <> Nil Then
        Tree.Destroy();
    Tree := TTree.Create();
    For I := 1 To Size Do
    Begin
        Tree.Add(StrToInt(StrGrList.Cells[I, 1]));
    End;
    ListOfValues := Tree.FindValues();
    If ListOfValues.Count = 0 Then
        LValuesOfTree.Caption := 'Таких вершин не существует в данном дереве!'
    Else
        LValuesOfTree.Caption := '';
    For I := 1 To ListOfValues.Count Do
    Begin
        LValuesOfTree.Caption := LValuesOfTree.Caption +
            IntToStr(ListOfValues[I - 1]) + ' ';
    End;
    LValuesOfTree.Visible := True;
    BitbtShowTree.Enabled := True;
    BitbtShowTree.Visible := True;
    BtSaveFile.Enabled := True;
    IsFileSaved := False;
    IsBitBtFindPressed := True;
End;

Procedure TuVCLMain.BitBtFindRootsKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (BitBtShowTree.Enabled) And ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := BitBtShowTree;
    If (Key = VK_UP) Then
        ActiveControl := StrGrList;
End;

Procedure TuVCLMain.BitBtShowTreeClick(Sender: TObject);
Var
    I: Integer;
Begin
    If Not IsBitBtFindPressed Then
    Begin
        If Tree <> Nil Then
            Tree.Destroy();
        Tree := TTree.Create();
        For I := 1 To Size Do
        Begin
            Tree.Add(StrToInt(StrGrList.Cells[I, 1]));
        End;
    End;
    Application.CreateForm(TuVCLOutputTree, UVCLOutputTree);
    UVCLOutputTree.ShowModal;
    UVCLOutputTree.Destroy;
End;

Procedure TuVCLMain.StrGrListKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    BtSaveFile.Enabled := False;
    IsFileSaved := False;
    If Key = VK_UP Then
        ActiveControl := ESize;
    If (BitBtFindRoots.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := BitBtFindRoots
    Else If Not(BitBtFindRoots.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := ESize;
    If (BitBtFindRoots.Enabled) And (IsArrayFilled) And (Key = VK_RETURN) Then
        ActiveControl := BitBtFindRoots;
End;

Procedure TuVCLMain.StrGrListKeyPress(Sender: TObject; Var Key: Char);
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

Procedure TuVCLMain.StrGrListKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Counter, I: Integer;
Begin
    Counter := 0;
    For I := 1 To Size Do
    Begin
        If (Length(StrGrList.Cells[I, 1]) <> 0) And
            (StrGrList.Cells[I, 1] <> '-') Then
            Inc(Counter);
    End;
    If Counter = Size Then
        IsArrayFilled := True
    Else
        IsArrayFilled := False;
    BitBtFindRoots.Visible := IsArrayFilled;
    BitBtFindRoots.Enabled := IsArrayFilled;
    LValuesOfTree.Visible := False;
    BitBtShowTree.Visible := IsArrayFilled;
    BitBtShowTree.Enabled := IsArrayFilled;
End;

Procedure TuVCLMain.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Not IsBitBtFindPressed Or IsFileSaved Then
    Begin
        Application.CreateForm(TuVCLExit, UVCLExit);
        UVCLExit.ShowModal;
        CanClose := UVCLExit.GetStatus();
        UVCLExit.Destroy();
    End
    Else If IsBitBtFindPressed Then
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
