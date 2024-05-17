Unit UnitMain;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons,
    System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Grids,
    UnitBackend, UnitAboutTheDeveloper, UnitInstruction, UnitDeleter, UnitExit;

Type
    TuVCLMain = Class(TForm)
        MainMenu1: TMainMenu;
        BtFile: TMenuItem;
        BtOpenFile: TMenuItem;
        BtSaveFile: TMenuItem;
        BtInstruction: TMenuItem;
        BtAboutTheDeveloper: TMenuItem;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        ImageList1: TImageList;
        StrGrWorkers: TStringGrid;
        LbInfo: TLabel;
        EFieldA: TEdit;
        EFieldB: TEdit;
        EFieldC: TEdit;
        LbInfoA: TLabel;
        LbInfoB: TLabel;
        LbInfoC: TLabel;
        LTableName: TLabel;
        BitBtAddWorker: TBitBtn;
        BitBtDeleteWorker: TBitBtn;
        BitbtShowDopInfo: TBitBtn;
        ECompany: TEdit;
        LCompanyInfo: TLabel;
        BtSaveDopInfo: TMenuItem;
        Procedure FormCreate(Sender: TObject);
        Procedure StrGrWorkersKeyPress(Sender: TObject; Var Key: Char);
        Procedure StrGrWorkersKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure EFieldChange(Sender: TObject);
        Procedure BtAboutTheDeveloperClick(Sender: TObject);
        Procedure BtInstructionClick(Sender: TObject);
        Procedure BtOpenFileClick(Sender: TObject);
        Procedure BtSaveFileClick(Sender: TObject);
        Procedure StrGrWorkersKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure BitBtAddWorkerClick(Sender: TObject);
        Procedure BitBtDeleteWorkerClick(Sender: TObject);
        Procedure EFieldAKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure EFieldBKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure EFieldCKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure ECompanyChange(Sender: TObject);
        Procedure ECompanyKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure BitbtShowDopInfoClick(Sender: TObject);
        Procedure EFieldKeyPress(Sender: TObject; Var Key: Char);
        Procedure ECompanyKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Private
        Workers: TWorkers;
        IsTableFilled: Boolean;
        BufferHandler: TBufferHandler;
        IsFileSaved: Boolean;
        Procedure ClearRow(Const Index: Integer);
    Public
        { Public declarations }
    End;

Var
    UVCLMain: TuVCLMain;

Implementation

{$R *.dfm}

Procedure TuVCLMain.BitBtAddWorkerClick(Sender: TObject);
Begin
    StrGrWorkers.RowCount := StrGrWorkers.RowCount + 1;
    StrGrWorkers.Cells[0, StrGrWorkers.RowCount - 1] :=
        IntToStr(StrGrWorkers.RowCount - 1);
    BitBtDeleteWorker.Enabled := (StrGrWorkers.RowCount > 2);
    // ���������� ������ ���������
    BtSaveFile.Enabled := False;
End;

Procedure TuVCLMain.BitBtDeleteWorkerClick(Sender: TObject);
Var
    IndexOfDeletedWorker: Integer;
    I: Integer;
Begin
    Application.CreateForm(TuVCLDeleter, UVCLDeleter);
    UVCLDeleter.CountOfWorkers := StrGrWorkers.RowCount -
        StrGrWorkers.FixedRows;
    UVCLDeleter.ShowModal();
    If UVCLDeleter.IsChosen And (StrGrWorkers.RowCount > 2) Then
    Begin
        // ����� �� ��� ����� ����������)
        IndexOfDeletedWorker := StrToInt(UVCLDeleter.ENumberOfWorker.Text);
        // �������� ���� ����������� ����� �� 1 ������ �����
        For I := IndexOfDeletedWorker To StrGrWorkers.RowCount - 1 Do
        Begin
            StrGrWorkers.Cells[1, I] := StrGrWorkers.Cells[1, I + 1];
            StrGrWorkers.Cells[2, I] := StrGrWorkers.Cells[2, I + 1];
            StrGrWorkers.Cells[3, I] := StrGrWorkers.Cells[3, I + 1];
            StrGrWorkers.Cells[4, I] := StrGrWorkers.Cells[4, I + 1];
            StrGrWorkers.Cells[5, I] := StrGrWorkers.Cells[5, I + 1];
        End;
        // ������� ��������� ������
        ClearRow(StrGrWorkers.RowCount);
        // �������� ����(���������) ������
        StrGrWorkers.RowCount := StrGrWorkers.RowCount - 1;
        // ���������� ������ ���������
        If IsTableFilled Then
            BtSaveFile.Enabled := True;
    End
    Else If UVCLDeleter.IsChosen And (StrGrWorkers.RowCount = 2) Then
    Begin
        // ������� ��������� ������
        ClearRow(StrGrWorkers.FixedRows);
        StrGrWorkers.Cells[0, StrGrWorkers.FixedRows] := '1';
    End;
    UVCLDeleter.Destroy();
End;

Procedure TuVCLMain.BitbtShowDopInfoClick(Sender: TObject);
Var
    I: Integer;
    IsCompanyExist: Boolean;
    FileWriter: TFileWriter;
    CurCompany: String;
    CountOfAllDetailsByWorker: Integer;
    PriceA, PriceB, PriceC: Integer;
    SalaryOfWorker: Integer;
    AllSalariesOfCompany: Real;
    CountOfCompanyWorkers: Integer;
Begin
    IsCompanyExist := False;
    CurCompany := ECompany.Text;
    // ����� ��������
    For I := 1 To Workers.Count Do
        If Not IsCompanyExist And (Workers[I - 1].CompanyName = CurCompany) Then
            IsCompanyExist := True;
    If IsCompanyExist And SaveDialog1.Execute() Then
    Begin
        // ������� ������ ��� ������ ������
        FileWriter := TFileWriter.Create(TfText);
        FileWriter.FileName := SaveDialog1.FileName;
        FileWriter.CheckFile();
        If FileWriter.Status = FsGood Then
        Begin
            // ������� ������ �� �����
            FileWriter.ResetFile();
            // ����������� ���������� �������� ���� �� �� ������
            AllSalariesOfCompany := 0;
            // ����������� ��������� �������� ������� ����� ������
            CountOfCompanyWorkers := 0;
            // ������ �������� �������� ��� ��
            PriceA := StrToInt(EFieldA.Text);
            PriceB := StrToInt(EFieldB.Text);
            PriceC := StrToInt(EFieldC.Text);
            FileWriter.WriteStrln(('���������� � ���� "' + CurCompany + '":'));
            For I := 1 To Workers.Count Do
            Begin
                If (Workers[I - 1].CompanyName = CurCompany) Then
                Begin
                    // ������� � ������ ������ ���������� ������� ��������� �, �, �,
                    // ��������� ������� ������� X
                    CountOfAllDetailsByWorker := Workers[I - 1].CountOfDetailsA
                        + Workers[I - 1].CountOfDetailsB + Workers[I - 1]
                        .CountOfDetailsC;
                    FileWriter.WriteStrln
                        (('������� ' + Workers[I - 1].Surname + ' ������ ' +
                        IntToStr(CountOfAllDetailsByWorker) + ' �������.'));
                    // ������� � ������ ��������� ���������� ����� ������� ���� X;
                    SalaryOfWorker := PriceA * Workers[I - 1].CountOfDetailsA +
                        PriceB * Workers[I - 1].CountOfDetailsB + PriceC *
                        Workers[I - 1].CountOfDetailsC;
                    FileWriter.WriteStrln
                        (('������� ' + Workers[I - 1].Surname +
                        ' �������� �� � ������� ' + IntToStr(SalaryOfWorker)
                        + ' ���'));
                    // ���������� �� � ������ �����
                    AllSalariesOfCompany := AllSalariesOfCompany +
                        SalaryOfWorker;
                    // ��������� �������� �������� ���� �������� �� 1
                    Inc(CountOfCompanyWorkers);
                End;
            End;
            // ������ ������� ������ ���������� ����� ���������� ���� ��������.
            AllSalariesOfCompany := AllSalariesOfCompany /
                CountOfCompanyWorkers;
            FileWriter.WriteStrln(('������ �� � ' + CurCompany + ' - ' +
                FloatToStr(AllSalariesOfCompany) + ' ���.'));
            MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                '��-���', MB_OK);
        End
        Else
            MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                '��-���', MB_ICONERROR);
    End
    Else
        MessageBox(UVCLMain.Handle, '��� �� ����������!', '��-���',
            MB_ICONERROR);
End;

Procedure TuVCLMain.BtAboutTheDeveloperClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLAboutTheDeveloper, UVCLAboutTheDeveloper);
    UVCLAboutTheDeveloper.Show();
    If UVCLAboutTheDeveloper.IsClose Then
        UVCLAboutTheDeveloper.Destroy();
End;

Procedure TuVCLMain.BtInstructionClick(Sender: TObject);
Begin
    Application.CreateForm(TuVCLInstruction, UVCLInstruction);
    UVCLInstruction.Show();
    If UVCLInstruction.IsClose Then
        UVCLInstruction.Destroy();
End;

Procedure TuVCLMain.EFieldChange(Sender: TObject);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    BufferHandler.EditText := CurEdit.Text;
    If Not BufferHandler.CheckInput(TpInteger) Then
    Begin
        MessageBox(UVCLMain.Handle, '�� ����� ������������ �������!', '��-���',
            MB_ICONERROR);
        CurEdit.Text := '';
    End;
    BufferHandler.DeleteLeadingZeros(TpInteger);
    CurEdit.Text := BufferHandler.EditText;
    BitbtShowDopInfo.Enabled := Not String.IsNullOrEmpty(EFieldA.Text) And
        Not String.IsNullOrEmpty(EFieldB.Text) And
        Not String.IsNullOrEmpty(EFieldC.Text) And
        Not String.IsNullOrEmpty(ECompany.Text) And IsTableFilled;
    BtSaveDopInfo.Enabled := BitbtShowDopInfo.Enabled;
End;

Procedure TuVCLMain.EFieldCKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If Key = VK_UP Then
        ActiveControl := BitBtDeleteWorker;
    If (Key = VK_LEFT) Then
        ActiveControl := EFieldB;
    If (Key = VK_DOWN) And BitbtShowDopInfo.Enabled Then
        ActiveControl := BitbtShowDopInfo;
    If (Key = VK_DOWN) And Not BitbtShowDopInfo.Enabled Then
        ActiveControl := ECompany;
    If (Key = VK_RIGHT) Then
        ActiveControl := ECompany;
End;

Procedure TuVCLMain.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ExitCode: Integer;
Begin
    If Not IsTableFilled Or IsFileSaved Then
    Begin
        Application.CreateForm(TuVCLExit, UVCLExit);
        UVCLExit.ShowModal;
        CanClose := UVCLExit.GetStatus();
        UVCLExit.Destroy();
    End
    Else If Not IsFileSaved Then
    Begin
        Repeat
            ExitCode := MessageBox(UVCLMain.Handle,
                '��������� ������ � ���� ����� �������?', '������������',
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
    // ������������� �������
    StrGrWorkers.FixedCols := 1;
    StrGrWorkers.FixedRows := 1;
    StrGrWorkers.RowCount := 2;
    StrGrWorkers.Cells[0, 0] := '�';
    StrGrWorkers.ColWidths[0] := 35;
    StrGrWorkers.Cells[1, 0] := '�������';
    StrGrWorkers.ColWidths[1] := 100;
    StrGrWorkers.Cells[2, 0] := '�������� ����';
    StrGrWorkers.ColWidths[2] := 120;
    StrGrWorkers.Cells[3, 0] := 'A(���.)';
    StrGrWorkers.ColWidths[3] := 55;
    StrGrWorkers.Cells[4, 0] := 'B(���.)';
    StrGrWorkers.ColWidths[4] := 55;
    StrGrWorkers.Cells[5, 0] := 'C(���.)';
    StrGrWorkers.ColWidths[5] := 55;
    StrGrWorkers.Cells[0, 1] := '1';
    // ������������� ����������
    Workers := TWorkers.Create();
    // ������������� ����������� ������
    BufferHandler := TBufferHandler.Create();
    // ������������� ����������
    IsFileSaved := False;
End;

Procedure TuVCLMain.BtOpenFileClick(Sender: TObject);
Var
    FileReader: TFileReader;
    I: Integer;
    Worker: TWorker;
Begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create();
        FileReader.FileName := OpenDialog1.FileName;
        FileReader.CheckFile();
        // TODO �������
        If FileReader.Status = FsGood Then
        Begin
            Workers := FileReader.ReadTable();
            For I := Workers.Count + StrGrWorkers.FixedRows To StrGrWorkers.
                RowCount - StrGrWorkers.FixedRows Do
                ClearRow(I);
            StrGrWorkers.RowCount := Workers.Count + StrGrWorkers.FixedRows;
            For I := StrGrWorkers.FixedRows To Workers.Count Do
            Begin
                Worker := Workers[I - 1];
                StrGrWorkers.Cells[0, I] := IntToStr(I);
                StrGrWorkers.Cells[1, I] := Worker.Surname;
                StrGrWorkers.Cells[2, I] := Worker.CompanyName;
                StrGrWorkers.Cells[3, I] := IntToStr(Worker.CountOfDetailsA);
                StrGrWorkers.Cells[4, I] := IntToStr(Worker.CountOfDetailsB);
                StrGrWorkers.Cells[5, I] := IntToStr(Worker.CountOfDetailsC);
            End;
            // ��������� ������ ���������
            BtSaveFile.Enabled := True;
            IsTableFilled := True;
        End
        Else
            MessageBox(UVCLMain.Handle, ListOfMessages[FileReader.Status],
                '��-���', MB_ICONERROR);
    End;
End;

Procedure TuVCLMain.BtSaveFileClick(Sender: TObject);
Var
    FileWriter: TFileWriter;

Begin
    If SaveDialog1.Execute() Then
    Begin
        FileWriter := TFileWriter.Create(TfWorkers);
        FileWriter.FileName := SaveDialog1.FileName;
        FileWriter.CheckFile();
        If FileWriter.Status = FsGood Then
        Begin
            FileWriter.SaveTable(Workers);
            If FileWriter.Status <> FsGood Then
            Begin
                MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                    '��-���', MB_ICONERROR);
            End
            else
                IsFileSaved := True;
        End
        Else
            MessageBox(UVCLMain.Handle, ListOfMessages[FileWriter.Status],
                '��-���', MB_ICONERROR);
        FileWriter.Destroy();
    End;
End;

Procedure TuVCLMain.ClearRow(Const Index: Integer);
Begin
    StrGrWorkers.Cells[0, Index] := '';
    StrGrWorkers.Cells[1, Index] := '';
    StrGrWorkers.Cells[2, Index] := '';
    StrGrWorkers.Cells[3, Index] := '';
    StrGrWorkers.Cells[4, Index] := '';
    StrGrWorkers.Cells[5, Index] := '';
End;

Procedure TuVCLMain.ECompanyChange(Sender: TObject);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    BufferHandler.EditText := CurEdit.Text;
    If Not BufferHandler.CheckInput(TpString) Then
    Begin
        MessageBox(UVCLMain.Handle, '�� ����� ������������ �������!', '��-���',
            MB_ICONERROR);
        CurEdit.Text := '';
    End;
    BufferHandler.DeleteLeadingZeros(TpInteger);
    CurEdit.Text := BufferHandler.EditText;
    BitbtShowDopInfo.Enabled := Not String.IsNullOrEmpty(EFieldA.Text) And
        Not String.IsNullOrEmpty(EFieldB.Text) And
        Not String.IsNullOrEmpty(EFieldC.Text) And
        Not String.IsNullOrEmpty(ECompany.Text) And IsTableFilled;
    BtSaveDopInfo.Enabled := BitbtShowDopInfo.Enabled;
End;

Procedure TuVCLMain.ECompanyKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (Key = VK_UP) Then
        ActiveControl := EFieldA;
    If (Key = VK_LEFT) Then
        ActiveControl := EFieldC;
    If ((Key = VK_RIGHT) Or (Key = VK_DOWN)) And BitbtShowDopInfo.Enabled Then
        ActiveControl := BitbtShowDopInfo;
    If ((Key = VK_RIGHT) Or (Key = VK_DOWN)) And
        Not BitbtShowDopInfo.Enabled Then
        ActiveControl := StrGrWorkers;
End;

Procedure TuVCLMain.ECompanyKeyPress(Sender: TObject; Var Key: Char);
Const
    MAX_COUNT_OF_LETTERS_FACTORY_NAME: Integer = 16;
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    If (Length(CurEdit.Text) > MAX_COUNT_OF_LETTERS_FACTORY_NAME) And
        (Key <> #08) Then
        Key := #0;
End;

Procedure TuVCLMain.EFieldAKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (Key = VK_LEFT) Or (Key = VK_UP) Then
        ActiveControl := BitBtDeleteWorker;
    If (Key = VK_RIGHT) Or (Key = VK_DOWN) Then
        ActiveControl := EFieldB;
End;

Procedure TuVCLMain.EFieldKeyPress(Sender: TObject; Var Key: Char);
Const
    MAX_DIGITS: Integer = 4;
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    If (Length(CurEdit.Text) > MAX_DIGITS) And (Key <> #08) Then
        Key := #0;
End;

Procedure TuVCLMain.EFieldBKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (Key = VK_UP) Then
        ActiveControl := BitBtAddWorker;
    If (Key = VK_LEFT) Then
        ActiveControl := EFieldA;
    If (Key = VK_RIGHT) Or (Key = VK_DOWN) Then
        ActiveControl := EFieldC;
End;

Procedure TuVCLMain.StrGrWorkersKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (StrGrWorkers.Col = StrGrWorkers.ColCount - StrGrWorkers.FixedCols) And
        (StrGrWorkers.Row = StrGrWorkers.RowCount - StrGrWorkers.FixedRows) And
        ((Key = VK_RETURN) Or (Key = VK_RIGHT) Or (Key = VK_DOWN)) Then
        ActiveControl := BitBtAddWorker;
    If (StrGrWorkers.Col = StrGrWorkers.FixedCols) And
        (StrGrWorkers.Row = StrGrWorkers.FixedRows) And
        BitbtShowDopInfo.Enabled And ((Key = VK_LEFT) Or (Key = VK_UP)) Then
        ActiveControl := BitbtShowDopInfo;
    If (StrGrWorkers.Col = StrGrWorkers.FixedCols) And
        (StrGrWorkers.Row = StrGrWorkers.FixedRows) And
        Not BitbtShowDopInfo.Enabled And ((Key = VK_LEFT) Or (Key = VK_UP)) Then
        ActiveControl := ECompany;
End;

Procedure TuVCLMain.StrGrWorkersKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['0' .. '9'];
    MAX_DIGITS: Integer = 5;
    MAX_COUNT_OF_LETTERS_SERNAME: Integer = 13;
    MAX_COUNT_OF_LETTERS_FACTORY_NAME: Integer = 17;
Var
    ArrGrid: TStringGrid;
    TempNumber: String;
Begin
    ArrGrid := TStringGrid(Sender);
    TempNumber := ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row];
    If (Key = #08) And (Length(ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row])
        <> 0) Then
    Begin
        Delete(TempNumber, Length(TempNumber), 1);
        ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] := TempNumber;
    End;
    // ��� ���������� ������� �������� �� ����
    If (ArrGrid.Col = 3) Or (ArrGrid.Col = 4) Or (ArrGrid.Col = 5) Then
    Begin
        If (Length(TempNumber) = 1) And (TempNumber = '0') And (Key <> #08) Then
            Key := #0;
        If (Key <> #0) And (Key In GOOD_KEYS) And
            (Length(TempNumber) < MAX_DIGITS) Then
            ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] :=
                ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] + Key;
    End
    // ��� �������
    Else If (Key <> #08) And (ArrGrid.Col = 1) And
        (Length(TempNumber) < MAX_COUNT_OF_LETTERS_SERNAME) Then
        ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] :=
            ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] + Key
        // ��� ����. ��������
    Else If (Key <> #08) And (ArrGrid.Col = 2) And
        (Length(TempNumber) < MAX_COUNT_OF_LETTERS_FACTORY_NAME) Then
        ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] :=
            ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] + Key;
    // �������� � ������� enter
    If (Key = #13) And (ArrGrid.Col = ArrGrid.ColCount - 1) And
        (ArrGrid.Row <> ArrGrid.RowCount - 1) Then
    Begin
        ArrGrid.Col := 1;
        ArrGrid.Row := ArrGrid.Row + 1;
    End
    Else If (Key = #13) And (ArrGrid.Col < ArrGrid.ColCount - 1) Then
        ArrGrid.Col := ArrGrid.Col + 1;
End;

Procedure TuVCLMain.StrGrWorkersKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    I: Integer;
    Worker: TWorker;
Begin
    // ���������� ���������
    IsTableFilled := True;
    For I := 1 To StrGrWorkers.RowCount - 1 Do
        If (StrGrWorkers.Cells[1, I] = '') Or (StrGrWorkers.Cells[2, I] = '') Or
            (StrGrWorkers.Cells[3, I] = '') Or (StrGrWorkers.Cells[4, I] = '')
            Or (StrGrWorkers.Cells[5, I] = '') Then
            IsTableFilled := False;
    If IsTableFilled Then
    Begin
        // ������ ������
        Workers.Count := StrGrWorkers.RowCount - 1;
        For I := 1 To StrGrWorkers.RowCount - 1 Do
        Begin
            Worker.ID := I;
            Worker.Surname := StrGrWorkers.Cells[1, I];
            Worker.CompanyName := StrGrWorkers.Cells[2, I];
            Worker.CountOfDetailsA := StrToInt(StrGrWorkers.Cells[3, I]);
            Worker.CountOfDetailsB := StrToInt(StrGrWorkers.Cells[4, I]);
            Worker.CountOfDetailsC := StrToInt(StrGrWorkers.Cells[5, I]);
            Workers[I - 1] := Worker;
        End;
        // ��������� ������ ���������
        BtSaveFile.Enabled := True;
    End
    Else // ���������� ������ ���������
        BtSaveFile.Enabled := False;
    // �������� �� ������ � ��� ������ ����� ����� � ������
    BitbtShowDopInfo.Enabled := Not String.IsNullOrEmpty(EFieldA.Text) And
        Not String.IsNullOrEmpty(EFieldB.Text) And
        Not String.IsNullOrEmpty(EFieldC.Text) And
        Not String.IsNullOrEmpty(ECompany.Text) And IsTableFilled;
    BtSaveDopInfo.Enabled := BitbtShowDopInfo.Enabled;
    // ������ ������ ����������
    IsFileSaved := False;
End;

End.
