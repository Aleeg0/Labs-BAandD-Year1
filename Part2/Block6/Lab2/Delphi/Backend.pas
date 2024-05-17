Unit Backend;

Interface

Uses System.SysUtils;

Type
    TMatrix = Array Of Array Of Integer;

    TTypes = (TpInteger, TpUInteger, TpReal, TpString);

    TBufferHandler = Class
    Private
        FEditText: String;
        Function CountSymbol(Const Symbol: Char): Integer;
    Public
        Function CheckInput(Const InputType: TTypes): Boolean;
        Function CheckRange(Const MIN, MAX; Const InputType: TTypes): Boolean;
        Function IsOdd(): Boolean;
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
        Function ReadSize(): Integer;
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
        Procedure WriteList(Var Matrix: TMatrix);
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

Implementation

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

Function TBufferHandler.CheckRange(Const MIN, MAX;
    Const InputType: TTypes): Boolean;
Var
    IsGood: Boolean;
Begin
    IsGood := True;
    Case InputType Of
        TpInteger:
            Begin
                Var
                    Number: Integer;
                Number := StrToInt(FEditText);
                If (Number < Integer(MIN)) Or (Integer(MAX) < Number) Then
                    IsGood := False;
            End;
        TpUInteger:
            Begin
                Var
                    Number: UInt32;
                Number := StrToUInt(FEditText);
                If (Number < Uint32(MIN)) Or (UInt32(MAX) < Number) Then
                    IsGood := False;
            End;
        TpReal:
            Begin
                // так нельзя, но можно, если осторожно :)
                Var
                    Number: Real;
                Number := StrToFloat(FEditText);
                If (Number < Real(MIN)) Or (Real(MAX) < Number) Then
                    IsGood := False;
            End;
        TpString:
            // ахах ну это тип прикол
            ;
    Else
        ;
    End;
    CheckRange := IsGood;
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

Function TBufferHandler.IsOdd: Boolean;
Var
    Answer: Boolean;
    Value: Integer;
Begin
    Value := StrToInt(FEditText);
    If (Value Mod 2) <> 0 Then
        Answer := True
    Else
        Answer := False;
    IsOdd := Answer;
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

Function TFileReader.IsEmpty: Boolean;
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

Function TFileReader.ReadSize(): Integer;
Var
    Size: Integer;
Begin
    Size := 0;
    Try
        ReSet(FInFile);
        Readln(FInFile, Size);
        CloseFile(FInFile);
    Except
        FFileStatus := FsUnexpected;
    End;
    If (Size < 3) Or (Size > 9) Then
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

Procedure TFileWriter.WriteList(Var Matrix: TMatrix);
Var
    I, J: Integer;
Begin
    Try
        ReWrite(FOutFile);
        Writeln(FOutFile, 'Магический квадрат.');
        For I := 0 To High(Matrix) Do
        Begin
            For J := 0 To High(Matrix[0]) Do
                Write(FOutFile, Matrix[I][J], ' ');
            Writeln(FOutFile);
        End;
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
