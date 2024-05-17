Unit BackendUnit5_1;

Interface

Uses System.SysUtils, System.Generics.Collections;

Type

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
        FsEmpty, FsWrongData, FsUnexpected);

    TFileReader = Class
    Private
        FFileName: String;
        FInFile: TextFile;
        FFileStatus: TFileStatus;
        Function IsFileTxt(): Boolean;
        Function IsFileReadable(): Boolean;
        Function IsEmpty(): Boolean;
        Procedure SetFileName(Const FFileName: String);
    Public
        Property Status: TFileStatus Read FFileStatus;
        Property FileName: String Read FFileName Write SetFileName;
        Procedure CheckFile();
        Function ReadSize(Const NumberOfList: Integer): Integer;
        Function ReadList(Const Size, NumberOfList: Integer): TList<Integer>;
    End;

    TFileWriter = Class
    Private
        FFileName: String;
        FOutFile: TextFile;
        FFileStatus: TFileStatus;
        Function IsFileTxt(): Boolean;
        Function IsFileWritable(): Boolean;
        Procedure SetFileName(Const FFileName: String);
    Public
        Constructor Create();
        Property Status: TFileStatus Read FFileStatus;
        Property FileName: String Read FFileName Write SetFileName;
        Procedure CheckFile();
        Procedure WriteList(Var List: TList<Integer>);
    End;

    TListOfMessages = Array [TFileStatus] Of PWideChar;

Const
    ListOfMessages: TListOfMessages = ('Информация записана!',
        'Файл не найден! Повторите ещё раз.',
        'Файл не текстовый! Повторите ещё раз.',
        'Файл не доступен для чтения! Повторите ещё раз.',
        'Файл не доступен для записи! Повторите ещё раз.',
        'Файл пустой! Повторите ещё раз.',
        'Не верные данные в файле! Повторите ещё раз.',
        'Упс... Что-то пошло не так. Потворите ещё раз.');

Function MergeTwoLists(Var List1, List2: TList<Integer>): TList<Integer>;

Var
    MergedList: TList<Integer>;

Implementation

{ MergeFunction }

Function MergeTwoLists(Var List1, List2: TList<Integer>): TList<Integer>;
Var
    LeftPtr: Integer;
    RightPtr: Integer;
    Steps: Integer;
    List3: TList<Integer>;
Begin
    LeftPtr := 0;
    RightPtr := 0;
    Steps := List1.Count + List2.Count;
    List3 := TList<Integer>.Create;
    While ((LeftPtr < List1.Count) Or (RightPtr < List2.Count)) Do
    Begin
        If LeftPtr > List1.Count - 1 Then
        Begin
            While RightPtr < List2.Count Do
            Begin
                List3.Add(List2[RightPtr]);
                Inc(RightPtr);
            End;
        End
        Else If RightPtr > List2.Count - 1 Then
        Begin
            While LeftPtr < List1.Count Do
            Begin
                List3.Add(List1[LeftPtr]);
                Inc(LeftPtr);
            End;
        End
        Else If List1[LeftPtr] > List2[RightPtr] Then
        Begin
            List3.Add(List2[RightPtr]);
            Inc(RightPtr);
        End
        Else
        Begin
            List3.Add(List1[LeftPtr]);
            Inc(LeftPtr);
        End;
    End;
    MergeTwoLists := List3;
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
    Else If Not IsFileTxt() Then
        FFileStatus := FsNotTxt
    Else If Not IsFileReadable() Then
        FFileStatus := FsNotReadable
    Else If IsEmpty() Then
        FFileStatus := FsEmpty
    Else
        FFileStatus := FsGood;
End;


function TFileReader.IsEmpty: Boolean;
Var
    Status: Boolean;
Begin
    Try
        Reset(FInFile);
        Status := Eof(FInFile);
        CloseFile(FInFile);
    Except
    End;
    IsEmpty := Status;
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

Function TFileReader.ReadList(Const SIZE, NumberOfList: Integer)
    : TList<Integer>;
Var
    List: TList<Integer>;
    I: Integer;
    Num: Integer;
Begin
    List := TList<Integer>.Create;
    Try
        ReSet(FInFile);
        If NumberOfList = 2 Then
        Begin
            Readln(FInFile);
            Readln(FInFile);
        End;
        Readln(FInFile);
        For I := 1 To SIZE Do
        Begin
            if Eof(FInFile) then
                FFileStatus := FsWrongData
            else
            begin
                Read(FInFile, Num);
                List.Add(Num);
            end;
        End;
        CloseFile(FInFile);
    Except
        FFileStatus := FsUnexpected;
    End;
    ReadList := List;
End;

Function TFileReader.ReadSize(Const NumberOfList: Integer): Integer;
Var
    Size: Integer;
Begin
    Size := 0;
    Try
        ReSet(FInFile);
        If (NumberOfList = 2) Then
        Begin
            Readln(FInFile);
            Readln(FInFile);
        End;
        Readln(FInFile, Size);
        CloseFile(FInFile);
    Except
        FFileStatus := FsUnexpected;
    End;
    if Size < 1 then
        FFileStatus := FsWrongData;
    ReadSize := Size;
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
    Try
        Rewrite(FOutFile);
        CloseFile(FOutFile);
    Except
        Status := False;
    End;
    IsFileWritable := Status;
End;

Procedure TFileWriter.SetFileName(Const FFileName: String);
Begin
    Self.FFileName := FFileName;
    Assign(FOutFile, Self.FFileName);
End;

Procedure TFileWriter.WriteList(Var List: TList<Integer>);
Var
    I: Integer;
Begin
    Try
        ReWrite(FOutFile);
        Writeln(FOutFile, 'Слитый воедино лист:');
        For I := 1 To List.Count Do
            Write(FOutFile, List[I-1], ' ');
        Writeln(FOutFile);
        CloseFile(FOutFile);
    Except
        FFileStatus := FsUnexpected;
    End;
End;

Constructor TFileWriter.Create();
Begin

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
