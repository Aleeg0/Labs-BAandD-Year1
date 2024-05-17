Unit MainFormUnit5_1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, System.ImageList,
    Vcl.ImgList, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus,
    InstructionUnit5_1, AboutTheDeveloperUnit5_1, BackendUnit5_1,
    OutputSortedArrayUnit5_1, ExitUnit5_1, System.Generics.Collections;

Type
    // форма
    TuVCLMain = Class(TForm)
        LbTaskInfo: TLabel;
        LbSize1Info: TLabel;
        ESize1: TEdit;
        BtAcceptSize1: TButton;
        StrGrList1: TStringGrid;
        ImageList1: TImageList;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        MainMenu1: TMainMenu;
        BtFile: TMenuItem;
        BtOpenFile: TMenuItem;
        BtSaveFile: TMenuItem;
        BtInstruction: TMenuItem;
        BtAboutTheDeveloper: TMenuItem;
        LbList1Info: TLabel;
        BitBtMergeLists: TBitBtn;
        BitBtShowList: TBitBtn;
        StrGrList2: TStringGrid;
        LbList2Info: TLabel;
        LbSize2Info: TLabel;
        ESize2: TEdit;
        BtAcceptSize2: TButton;
        Procedure ESize1KeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure ESize1KeyPress(Sender: TObject; Var Key: Char);
        Procedure BtInstructionClick(Sender: TObject);
        Procedure BtAboutTheDeveloperClick(Sender: TObject);
        Procedure ESize1Change(Sender: TObject);
        Procedure StrGrList1KeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure BtAccept1SizeClick(Sender: TObject);
        Procedure StrGrListKeyPress(Sender: TObject; Var Key: Char);
        Procedure BitBtMergeListsClick(Sender: TObject);
        Procedure BitBtShowListClick(Sender: TObject);
        Procedure BtOpenFileClick(Sender: TObject);
        Procedure BtSaveFileClick(Sender: TObject);

        Procedure StrGrList1KeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure BitBtMergeListsKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure BtAcceptSize2Click(Sender: TObject);
        Procedure ESize2Change(Sender: TObject);
        Procedure StrGrList2KeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
    Private
        IsFileSaved: Boolean;
        IsList1Filled: Boolean;
        IsList2Filled: Boolean;
        IsListDecreasing: Boolean;
        IsSortButtonPressed: Boolean;
        WasChanges1: Boolean;
        WasChanges2: Boolean;
        BufferHandler: TBufferHandler;
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
    UVCLAboutTheDeveloper.ShowModal;
    UVCLAboutTheDeveloper.Destroy();
    UVCLAboutTheDeveloper := Nil;
End;

Procedure TuVCLMain.BtAcceptSize2Click(Sender: TObject);
Const
    MAX_SIZE: Integer = 1000;
    MIN_SIZE: Integer = 0;
Var
    I: Integer;
    Size: Integer;
Begin
    // creating Grid
    Size := StrToInt(ESize2.Text);
    If WasChanges2 Then
    Begin
        If (MIN_SIZE < Size) And (Size < MAX_SIZE) Then
        Begin
            // list2
            StrGrList2.RowCount := 2;
            StrGrList2.ColCount := Size + 1;
            StrGrList2.FixedCols := 1;
            StrGrList2.FixedRows := 1;
            StrGrList2.Cells[0, 0] := '№';
            StrGrList2.Cells[0, 1] := 'Элемент';
            For I := 1 To Size Do
            Begin
                StrGrList2.Cells[I, 0] := IntToStr(I);
                StrGrList2.Cells[I, 1] := '';
            End;
            StrGrList2.Enabled := True;
            StrGrList2.Visible := True;
            LbList2Info.Visible := True;
            If StrGrList1.Visible Then
            Begin
                BitBtMergeLists.Visible := True;
                BitBtShowList.Visible := True;
                BitBtMergeLists.Enabled := False;
                BitBtShowList.Enabled := False;
            End;
            BtAcceptSize2.Enabled := False;
        End
        Else
            MessageBox(UVCLMain.Handle,
                'Размер не соответствует границам! Проверьте данные.', 'Ой-йой',
                MB_ICONERROR);
    End;
    WasChanges2 := False;
End;

Procedure TuVCLMain.BtInstructionClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLInstruction, UVCLInstruction);
    UVCLInstruction.ShowModal;
    UVCLInstruction.Destroy();
    UVCLInstruction := Nil;
End;

Procedure TuVCLMain.BtOpenFileClick(Sender: TObject);
Var
    FileReader: TFileReader;
    I: Integer;
    Arr: TArray;
    List1, List2: TList<Integer>;
    A : Word;
    b : TShiftState;
Begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create();
        FileReader.FileName := OpenDialog1.FileName;
        FileReader.CheckFile();
        // TODO статусы
        If FileReader.Status = FsGood Then
        Begin
            List1 := FileReader.ReadList(FileReader.ReadSize(1),1);
            List2 := FileReader.ReadList(FileReader.ReadSize(2),2);
            If (FileReader.Status = FsGood) Then
            Begin
                ESize1.Text := IntToStr(List1.Count);
                BtAcceptSize1.Click;
                ESize2.Text := IntToStr(List2.Count);
                BtAcceptSize2.Click;
                For I := 1 To List1.Count Do
                Begin
                    StrGrList1.Cells[I, 0] := IntToStr(I);
                    StrGrList1.Cells[I, 1] := IntToStr(List1[I - 1]);
                End;
                StrGrList1KeyUp(Sender,a,b);
                For I := 1 To List2.Count Do
                Begin
                    StrGrList2.Cells[I, 0] := IntToStr(I);
                    StrGrList2.Cells[I, 1] := IntToStr(List2[I - 1]);
                End;
                StrGrList2KeyUp(Sender,a,b);
            End
            else
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
            FileWriter.WriteList(MergedList);
            If FileWriter.Status <> FsGood Then
            Begin
                MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                    'Ой-йой', MB_ICONERROR);
            End
            else
                IsFileSaved := True;
        End
        Else
            MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                'Ой-йой', MB_ICONERROR);
        FileWriter.Destroy();
    End;
End;

Procedure TuVCLMain.BitBtShowListClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLOutputSortedArray, UVCLOutputSortedArray);
    UVCLOutputSortedArray.Show;
    If UVCLOutputSortedArray.IsClosed Then
    Begin
        UVCLOutputSortedArray.Destroy;
        UVCLOutputSortedArray := Nil;
    End;
End;

Procedure TuVCLMain.BtAccept1SizeClick(Sender: TObject);
Const
    MAX_SIZE: Integer = 1000;
    MIN_SIZE: Integer = 0;
Var
    I: Integer;
    Size: Integer;
Begin
    // creating Grid
    Size := StrToInt(ESize1.Text);
    If WasChanges1 Then
    Begin
        If (MIN_SIZE < Size) And (Size < MAX_SIZE) Then
        Begin
            // list1
            StrGrList1.RowCount := 2;
            StrGrList1.ColCount := Size + 1;
            StrGrList1.FixedCols := 1;
            StrGrList1.FixedRows := 1;
            StrGrList1.Cells[0, 0] := '№';
            StrGrList1.Cells[0, 1] := 'Элемент';
            For I := 1 To Size Do
            Begin
                StrGrList1.Cells[I, 0] := IntToStr(I);
                StrGrList1.Cells[I, 1] := '';
            End;
            StrGrList1.Enabled := True;
            StrGrList1.Visible := True;
            LbList1Info.Visible := True;
            If StrGrList2.Visible Then
            Begin
                BitBtMergeLists.Visible := True;
                BitBtShowList.Visible := True;
                BitBtMergeLists.Enabled := False;
                BitBtShowList.Enabled := False;
            End;

            BtAcceptSize1.Enabled := False;
        End
        Else
            MessageBox(UVCLMain.Handle,
                'Размер не соответствует границам! Проверьте данные.', 'Ой-йой',
                MB_ICONERROR);
    End;
    WasChanges1 := False;
End;

Procedure TuVCLMain.ESize1Change(Sender: TObject);
Var
    I, J: Integer;
    SizeEdit: TEdit;
    TempStr: String;
Begin
    SizeEdit := TEdit(Sender);
    BtAcceptSize1.Enabled := Not String.IsNullOrEmpty(SizeEdit.Text);
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
    If Not BtAcceptSize1.Enabled Then
    Begin
        StrGrList1.Enabled := False;
    End;
    If WasChanges1 Then
    Begin
        // Очистка всех ячеек StringGrid
        For I := 1 To StrGrList1.RowCount Do
        Begin
            For J := 1 To StrGrList1.ColCount Do
            Begin
                StrGrList1.Cells[J - 1, I - 1] := '';
            End;
        End;
        IsList1Filled := False;
        LbList1Info.Visible := False;
        StrGrList1.Visible := False;
        BitBtMergeLists.Visible := False;
        BitBtShowList.Visible := False;
        BitBtMergeLists.Enabled := False;
        BitBtShowList.Enabled := False;
        BtSaveFile.Enabled := False;
    End;
    WasChanges1 := True;
End;

Procedure TuVCLMain.ESize1KeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    // when user change size
    If (BtAcceptSize1.Enabled) And (CurEdit.SelLength = 0) And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := BtAcceptSize1;
    If (BtAcceptSize1.Enabled) And (CurEdit.SelStart = Length(CurEdit.Text)) And
        ((Key = VK_RIGHT)) Then
        ActiveControl := BtAcceptSize1;
    If (BitBtShowList.Enabled) And ((Key = VK_UP) Or (Key = VK_LEFT)) Then
        ActiveControl := BitBtShowList;
    // when user's already pressed sizeButton
    If Not BtAcceptSize1.Enabled And StrGrList1.Enabled And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := StrGrList1;
    If Not BtAcceptSize1.Enabled And StrGrList1.Enabled And
        (CurEdit.SelStart = Length(CurEdit.Text)) And ((Key = VK_RIGHT)) Then
        ActiveControl := StrGrList1;
End;

Procedure TuVCLMain.ESize1KeyPress(Sender: TObject; Var Key: Char);
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

Procedure TuVCLMain.ESize2Change(Sender: TObject);
Var
    I, J: Integer;
    SizeEdit: TEdit;
    TempStr: String;
Begin
    SizeEdit := TEdit(Sender);
    BtAcceptSize2.Enabled := Not String.IsNullOrEmpty(SizeEdit.Text);
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
    If Not BtAcceptSize2.Enabled Then
    Begin
        StrGrList2.Enabled := False;
    End;
    If WasChanges2 Then
    Begin
        // Очистка всех ячеек StringGrid
        For I := 1 To StrGrList2.RowCount Do
        Begin
            For J := 1 To StrGrList2.ColCount Do
            Begin
                StrGrList2.Cells[J - 1, I - 1] := '';
            End;
        End;
        IsList2Filled := False;
        LbList2Info.Visible := False;
        StrGrList2.Visible := False;
        BitBtMergeLists.Visible := False;
        BitBtShowList.Visible := False;
        BitBtMergeLists.Enabled := False;
        BitBtShowList.Enabled := False;
        BtSaveFile.Enabled := False;
    End;
    WasChanges2 := True;
End;

Procedure TuVCLMain.BitBtMergeListsClick(Sender: TObject);
Var
    List1, List2: TList<Integer>;
    I: Integer;
    Size1, Size2: Integer;
Begin
    Size1 := StrToInt(ESize1.Text);
    Size2 := StrToInt(ESize2.Text);
    List1 := TList<Integer>.Create;
    List2 := TList<Integer>.Create;
    If Not IsListDecreasing Then
    Begin
        For I := 1 To Size1 Do
        Begin
            List1.Add(StrToInt(StrGrList1.Cells[I, 1]));
        End;
        For I := 1 To Size2 Do
        Begin
            List2.Add(StrToInt(StrGrList2.Cells[I, 1]));
        End;
        MergedList := MergeTwoLists(List1, List2);
    End
    Else
        MessageBox(UVCLMain.Handle, 'Списки введены не по возрастанию!',
            'ой-йой', MB_ICONEXCLAMATION);
    BitbtShowList.Enabled := True;
    BtSaveFile.Enabled := True;
    IsFileSaved := False;
    IsSortButtonPressed := True;
End;

Procedure TuVCLMain.BitBtMergeListsKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (BitBtShowList.Enabled) And ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := BitBtShowList;
    If (Key = VK_UP) Then
        ActiveControl := StrGrList1;
End;

Procedure TuVCLMain.StrGrList1KeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    BitBtShowList.Enabled := False;
    IsSortButtonPressed := False;
    BtSaveFile.Enabled := False;
    IsFileSaved := False;
    If Key = VK_UP Then
        ActiveControl := ESize1;
    If (BitBtMergeLists.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := BitBtMergeLists
    Else If Not(BitBtMergeLists.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := ESize1;
    If (BitBtMergeLists.Enabled) And (IsList1Filled) And (Key = VK_RETURN) Then
        ActiveControl := BitBtMergeLists;
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

Procedure TuVCLMain.StrGrList1KeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Counter, I: Integer;
    Size: Integer;
Begin
    Counter := 0;
    Size := StrGrList1.ColCount - 1;
    IsListDecreasing := False;
    For I := 1 To Size Do
    Begin
        If (Length(StrGrList1.Cells[I, 1]) <> 0) And
            (StrGrList1.Cells[I, 1] <> '-') Then
        Begin
            If (I = 1) Then
                Inc(Counter)
            Else If ((Length(StrGrList1.Cells[I - 1, 1]) <> 0) And
                (StrGrList1.Cells[I - 1, 1] <> '-')) Then
            Begin
                Inc(Counter);
                If (StrToInt(StrGrList1.Cells[I - 1, 1]) >
                    StrToInt(StrGrList1.Cells[I, 1])) Then
                    IsListDecreasing := True;
            End;
        End;
    End;
    If Counter = Size Then
        IsList1Filled := True
    Else
    Begin
        IsList1Filled := False;
        BitBtShowList.Enabled := False;
        BitBtMergeLists.Enabled := False;
        BtSaveFile.Enabled := False;
    End;
    If IsList2Filled Then
        BitBtMergeLists.Enabled := IsList1Filled;

End;

Procedure TuVCLMain.StrGrList2KeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Counter, I: Integer;
    Size: Integer;
Begin
    Counter := 0;
    Size := StrGrList2.ColCount - 1;
    IsListDecreasing := False;
    For I := 1 To Size Do
    Begin
        If (Length(StrGrList2.Cells[I, 1]) <> 0) And
            (StrGrList2.Cells[I, 1] <> '-') Then
        Begin
            If (I = 1) Then
                Inc(Counter)
            Else If ((Length(StrGrList2.Cells[I - 1, 1]) <> 0) And
                (StrGrList2.Cells[I - 1, 1] <> '-')) Then
            Begin
                Inc(Counter);
                If (StrToInt(StrGrList2.Cells[I - 1, 1]) >
                    StrToInt(StrGrList2.Cells[I, 1])) Then
                    IsListDecreasing := True;
            End;
        End;
    End;
    If Counter = Size Then
        IsList2Filled := True
    Else
    Begin
        IsList2Filled := False;
        BitBtShowList.Enabled := False;
        BitBtMergeLists.Enabled := False;
        BtSaveFile.Enabled := False;
    End;
    If IsList1Filled Then
        BitBtMergeLists.Enabled := IsList2Filled;
End;

Procedure TuVCLMain.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Not IsSortButtonPressed Or IsFileSaved Then
    Begin
        Application.CreateForm(TuVCLExit, UVCLExit);
        UVCLExit.ShowModal;
        CanClose := UVCLExit.GetStatus();
        UVCLExit.Destroy();
    End
    Else If IsSortButtonPressed Then
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

End.
