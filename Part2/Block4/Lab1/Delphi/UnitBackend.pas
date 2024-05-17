Unit UnitBackend;

Interface

Uses System.SysUtils;

Type
    TWorker = Record
        ID: Integer;
        Surname: String[13];
        CompanyName: String[18];
        CountOfDetailsA: Integer;
        CountOfDetailsB: Integer;
        CountOfDetailsC: Integer;
    End;

    TWorkers = Class
    Private
        FWorkersArray: Array Of TWorker;
        FWorkersCount: Integer;
        Procedure SetWorkersCount(Const WorkersCount: Integer);
        Procedure SetWorker(Index: Integer; Const Worker: TWorker);
        Function GetWorker(Index: Integer): TWorker;
    Public
        Constructor Create();
        Destructor Destroy();
        Property Count: Integer Read FWorkersCount Write SetWorkersCount;
        Property Worker[Index: Integer]: TWorker Read GetWorker
            Write SetWorker; Default;
    End;

    TTypes = (TpInteger, TpUInteger, TpReal, TpString);

    TBufferHandler = Class
    Private
        FEditText: String;
        Function CountSymbol(Const Symbol: Char): Integer;
    Public
        Function CheckInput(Const InputType: TTypes): Boolean;
        Procedure DeleteLeadingZeros(Const InputType: TTypes);
        Property EditText: String Read FEditText Write FEditText;
    End;

    TFileStatus = (FsGood, FsNotFound, FsNotTxt, FsNotReadable, FsNotWritable,
        FsUnexpected);

    TFileReader = Class
    Private
        FFileName: String;
        FInFile: File Of TWorker;
        FFileStatus: TFileStatus;
        Function IsFileTxt(): Boolean;
        Function IsFileReadable(): Boolean;
        Procedure SetFileName(Const FFileName: String);
    Public
        Property Status: TFileStatus Read FFileStatus;
        Property FileName: String Read FFileName Write SetFileName;
        Procedure CheckFile();
        Function ReadTable(): TWorkers;
    End;

    TTypeFile = (TfText, TfWorkers);

    TFileWriter = Class
    Private
        FFileName: String;
        FTypeFile: TTypeFile;
        FOutFileTxt: TextFile;
        FOutFile: File Of TWorker;
        FFileStatus: TFileStatus;
        Function IsFileTxt(): Boolean;
        Function IsFileWritable(): Boolean;
        Procedure SetFileName(Const FFileName: String);
    Public
        Constructor Create(Const TypeFile: TTypeFile);
        Property Status: TFileStatus Read FFileStatus;
        Property FileName: String Read FFileName Write SetFileName;
        Procedure CheckFile();
        Procedure SaveTable(Const Workers: TWorkers);
        Procedure WriteStr(Const Str: String);
        Procedure WriteStrln(Const Str: String);
        Procedure ResetFile();
    End;

    TListOfMessages = Array [TFileStatus] Of PWideChar;

Const
    ListOfMessages: TListOfMessages = ('Информация записана!',
        'Файл не найден! Повторите ещё раз.',
        'Файл не текстовый! Повторите ещё раз.',
        'Файл не доступен для чтения! Повторите ещё раз.',
        'Файл не доступен для записи! Повторите ещё раз.',
        'Упс... Что-то пошло не так. Потворите ещё раз.');

Implementation

{ TWorkers }

Constructor TWorkers.Create;
Begin
    FWorkersCount := 0;
End;

Destructor TWorkers.Destroy;
Begin
    FWorkersArray := Nil;
End;

Function TWorkers.GetWorker(Index: Integer): TWorker;
Begin
    GetWorker := FWorkersArray[Index];
End;

Procedure TWorkers.SetWorker(Index: Integer; Const Worker: TWorker);
Begin
    Try
        FWorkersArray[Index] := Worker;
    Except
        Inc(FWorkersCount);
        SetLength(FWorkersArray, FWorkersCount);
        FWorkersArray[Index] := Worker;
    End;
End;

Procedure TWorkers.SetWorkersCount(Const WorkersCount: Integer);
Begin
    FWorkersCount := WorkersCount;
    FWorkersArray := Nil;
    Setlength(FWorkersArray, FWorkersCount);
End;

{ TBufferHandler }

Function TBufferHandler.CheckInput(Const InputType: TTypes): Boolean;

Const
    GOOD_KEYS: Set Of Char = ['0' .. '9'];

Var
    Status: Boolean;
    I: Integer;
    CountOfMinuses: Integer;
    CountOfCommas: Integer;
Begin
    Status := True;
    Case InputType Of
        TpInteger:
            Begin
                CountOfMinuses := CountSymbol('-');
                If (CountOfMinuses = 0) Then
                Begin
                    For I := Low(FEditText) To High(FEditText) Do
                        If Status And Not(FEditText[I] In GOOD_KEYS) Then
                            Status := False;
                End
                Else If (CountOfMinuses = 1) Then
                Begin
                    For I := 2 To High(FEditText) Do
                        If Status And Not(FEditText[I] In GOOD_KEYS) Then
                            Status := False;
                End
                Else
                    Status := False;
            End;
        TpUInteger:
            Begin
                For I := Low(FEditText) To High(FEditText) Do
                    If Status And Not(FEditText[I] In GOOD_KEYS) Then
                        Status := False;
            End;
        TpReal:
            Begin
                CountOfMinuses := CountSymbol('-');
                CountOfCommas := CountSymbol(',');
                If (CountOfMinuses = 0) And (CountOfCommas = 0) Then
                Begin
                    For I := Low(FEditText) To High(FEditText) Do
                        If Status And Not(FEditText[I] In GOOD_KEYS) Then
                            Status := False;
                End
                Else If (CountOfMinuses = 1) And (CountOfCommas = 0) Then
                Begin
                    For I := 2 To High(FEditText) Do
                        If Status And Not(FEditText[I] In GOOD_KEYS) Then
                            Status := False;
                End
                Else If (CountOfMinuses = 0) And (CountOfCommas = 1) Then
                Begin
                    For I := 1 To High(FEditText) Do
                        If Status And
                            Not((FEditText[I] In GOOD_KEYS) Or
                            (FEditText[I] = ',')) Then
                            Status := False;
                End
                Else If (CountOfMinuses = 1) And (CountOfCommas = 1) Then
                Begin
                    For I := 2 To High(FEditText) Do
                        If Status And
                            Not((FEditText[I] In GOOD_KEYS) Or
                            (FEditText[I] = ',')) Then
                            Status := False;
                End
                Else
                    Status := False;
            End;
        TpString:
            Begin
                // why?
            End;
    End;
    CheckInput := Status;
End;

Function TBufferHandler.CountSymbol(Const Symbol: Char): Integer;

Var
    I: Integer;
    Count: Integer;
Begin
    Count := 0;
    For I := 1 To Length(FEditText) Do
        If FEditText[I] = Symbol Then
            Inc(Count);
    CountSymbol := Count;
End;

Procedure TBufferHandler.DeleteLeadingZeros(Const InputType: TTypes);
Begin
    Case InputType Of
        TpInteger:
            Begin
                If CountSymbol('-') = 1 Then
                    While (Length(FEditText) > 1) And (FEditText[2] = '0') Do
                        Delete(FEditText, 2, 1)
                Else
                    While (Length(FEditText) > 0) And (FEditText[1] = '0') Do
                        Delete(FEditText, 1, 1);
            End;
        TpUInteger:
            While (Length(FEditText) > 0) And (FEditText[1] = '0') Do
                Delete(FEditText, 1, 1);
        TpReal:
            // TODO
            ;
        TpString:
            // Why?
            ;
    End;

End;

{ TFileReader }

Procedure TFileReader.CheckFile();
Begin
    If Not FileExists(FileName) Then
        FFileStatus := FsNotFound
    Else If Not IsFileReadable Then
        FFileStatus := FsNotReadable
    Else
        FFileStatus := FsGood;
End;

Function TFileReader.IsFileReadable(): Boolean;

Var
    Status: Boolean;
Begin
    Status := True;
    Try
        Reset(FInFile);
        CloseFile(FInFile);
    Except
        Status := False;
    End;
    IsFileReadable := Status;
End;

Function TFileReader.IsFileTxt(): Boolean;

Var
    FileType: String;
    Status: Boolean;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Status := True
    Else
        Status := False;
    IsFileTxt := Status;
End;

Function TFileReader.ReadTable: TWorkers;

Var
    I: Integer;
    Worker: TWorker;
    Workers: TWorkers;
Begin
    I := 0;
    Workers := TWorkers.Create();
    Try
        ReSet(FInFile);
        While Not Eof(FINFile) Do
        Begin
            Read(FInFile, Worker);
            Workers[I] := Worker;
            Inc(I);
        End;
        CloseFile(FInFile);
    Except
        FFileStatus := FsUnexpected;
    End;
    ReadTable := Workers;
End;

Procedure TFileReader.SetFileName(Const FFileName: String);
Begin
    Self.FFileName := FFileName;
    Assign(FInFile, Self.FFileName);
End;

{ TFileWriter }

Procedure TFileWriter.CheckFile;
Begin
    If Not FileExists(FileName) Then
        FFileStatus := FsNotFound
    Else If Not IsFileWritable() Then
        FFileStatus := FsNotWritable
    Else
        FFileStatus := FsGood;
End;

Function TFileWriter.IsFileWritable(): Boolean;

Var
    Status: Boolean;
Begin
    Status := True;
    If FTypeFile = TfText Then
    Begin
        Try
            Rewrite(FOutFileTxt);
            CloseFile(FOutFiletxt);
        Except
            Status := False;
        End;
    End
    Else
    Begin
        Try
            Rewrite(FOutFile);
            CloseFile(FOutFile);
        Except
            Status := False;
        End;
    End;
    IsFileWritable := Status;
End;

Procedure TFileWriter.ResetFile;
Begin
    Try
        ReWrite(FOutFileTxt);
        CloseFile(FOutFileTxt);
    Except
        FFileStatus := FsUnexpected;
    End;
End;

Procedure TFileWriter.SaveTable(Const Workers: TWorkers);

Var
    I: Integer;
    Worker: TWorker;
Begin
    Try
        ReWrite(FOutFile);
        For I := 1 To Workers.Count Do
        Begin
            Worker := Workers[I - 1];
            Write(FOutFile, Worker);
        End;
        CloseFile(FOutFile);
    Except
        FFileStatus := FsUnexpected;
    End;
End;

Procedure TFileWriter.SetFileName(Const FFileName: String);
Begin
    Self.FFileName := FFileName;
    If FTypeFile = TfText Then
        Assign(FOutFileTxt, Self.FFileName)
    Else
        Assign(FOutFile, Self.FFileName);
End;

Procedure TFileWriter.WriteStr(Const Str: String);
Begin
    Try
        Append(FOutFileTxt);
        Write(FOutFileTxt, Str);
        CloseFile(FOutFileTxt);
    Except
        FFileStatus := FsUnexpected;
    End;
End;

Procedure TFileWriter.WriteStrln(Const Str: String);
Begin
    Try
        Append(FOutFileTxt);
        Writeln(FOutFileTxt, Str);
        CloseFile(FOutFileTxt);
    Except
        FFileStatus := FsUnexpected;
    End;
End;

Constructor TFileWriter.Create(Const TypeFile: TTypeFile);
Begin
    FTypeFile := TypeFile;
End;

Function TFileWriter.IsFileTxt: Boolean;

Var
    FileType: String;
    Status: Boolean;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Status := True
    Else
        Status := False;
    IsFileTxt := Status;
End;

End.
