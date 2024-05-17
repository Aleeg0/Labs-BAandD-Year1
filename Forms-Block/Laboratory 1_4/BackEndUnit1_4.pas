Unit BackEndUnit1_4;

Interface

Uses MainFormUnit1_4;

Type
    TArrayTransformator = Class
    Private
        UsersArray: TArrayOfInt;
        TransformatedArray: TArrayOfInt;
        Size: Integer;
    Public
        Function GetTransformatedArray(): TArrayOfInt;
        Function GetSizeOfArray(): Integer;
        Procedure SetUsersArray(Var UsersArray: TArrayOfInt);
        Procedure Transformation();
    End;

    TFileReader = Class
    Private
        FileName: String;
        InFile: TextFile;
        Status: Boolean;
        Function IsFileTxt(): Boolean;
        Function IsFileReadable(): Boolean;
    Public
        Function GetStatus(): Boolean;
        Procedure SetFileName(FileName: String);
        Function InputSize(): Integer;
        Function InputArray(Const SIZE: Integer): TArrayOfInt;
        Function IsFileGood(): Boolean;
    End;

    TFileWriter = Class
    Private
        OutFile: TextFile;
        FileName: String;
        Status: Boolean;
        Function IsFileTxt(): Boolean;
        Function IsFileWritable(): Boolean;
    Public
        Procedure SetFileName(FileName: String);
        Function GetStatus(): Boolean;
        Procedure OutputArray(Arr: TArrayOfInt; Const SIZE: Integer);
        Function IsFileGood(): Boolean;
    End;

Var
    Transformator: TArrayTransformator;

Implementation

Uses System.SysUtils;
{ TArrayTransformation }

// Methods of TArrayTransformation class
Function TArrayTransformator.GetSizeOfArray: Integer;
Begin
    GetSizeOfArray := Size;
End;

Function TArrayTransformator.GetTransformatedArray: TArrayOfInt;
Begin
    GetTransformatedArray := TransformatedArray;
End;

Procedure TArrayTransformator.SetUsersArray(Var UsersArray: TArrayOfInt);
Begin
    Size := Length(UsersArray);
    SetLength(Self.UsersArray, Size);
    Self.UsersArray := UsersArray;
End;

Procedure TArrayTransformator.Transformation;
Var
    I: Integer;
Begin
    SetLength(Self.TransformatedArray, Size);
    For I := 1 To Size Do
    Begin
        TransformatedArray[I - 1] := Self.UsersArray[I - 1] * 2 + I;
    End;
End;

// Methods of TFileReader class
Function TFileReader.GetStatus: Boolean;
Begin
    GetStatus := Status;
End;

Function TFileReader.IsFileTxt(): Boolean;
Var
    FileType: String;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Status := True
    Else
        Status := False;
    IsFileTxt := Status;
End;

Function TFileReader.IsFileReadable(): Boolean;
Begin
    Try
        Reset(InFile);
        Status := True;
        CloseFile(InFile);
    Finally
        Status := False;
    End;
    IsFileReadable := Status;
End;

Function TFileReader.IsFileGood(): Boolean;
Begin
    Status := False;
    If Not FileExists(FileName) Or Not(IsFileTxt() Or IsFileReadable()) Then
        Status := False
    Else
        Status := True;
    IsFileGood := Status;
End;

Procedure TFileReader.SetFileName(FileName: String);
Begin
    Self.FileName := FileName;
    Assign(InFile, Self.FileName);
End;

Function TFileReader.InputSize: Integer;
Const
    MIN_SIZE: Integer = 1;
    MAX_SIZE: Integer = 99;
Var
    Size: Integer;
Begin
    Size := 0;
    Reset(InFile);
    Try
        Read(InFile, Size);
    Except
        Status := False;
    End;
    If (Size < MIN_SIZE) Or (MAX_SIZE < Size) Then
    Begin
        Status := False;
    End;
    CloseFile(InFile);
    InputSize := Size;
End;

Function TFileReader.InputArray(Const SIZE: Integer): TArrayOfInt;
Const
    MIN_NUMBER: Integer = -99999;
    MAX_NUMBER: Integer = 99999;
Var
    IsCorrect: Boolean;
    Arr: TArrayOfInt;
    TempNumber, I: Integer;
Begin
    SetLength(Arr, SIZE);
    IsCorrect := False;
    Reset(InFile);
    Read(InFile, Arr[0]);
    For I := 1 To SIZE Do
    Begin
        If Status Then
        Begin
            Try
                Read(InFile, TempNumber);
            Except
                Status := False;
            End;
            If Status And ((TempNumber < MIN_NUMBER) Or
                (MAX_NUMBER < TempNumber)) Then
                Status := False
            Else If Status Then
                Arr[I - 1] := TempNumber;

        End;
    End;
    CloseFile(InFile);
    InputArray := Arr;
End;

// Methods of TFileWriter class
Function TFileWriter.GetStatus: Boolean;
Begin
    GetStatus := Status;
End;

Function TFileWriter.IsFileTxt(): Boolean;
Var
    FileType: String;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Status := True
    Else
        Status := False;
    IsFileTxt := Status;
End;

Function TFileWriter.IsFileWritable(): Boolean;
Begin
    Try
        ReWrite(OutFile);
        Status := True;
        CloseFile(OutFile);
    Except
        Status := False;
    End;
    IsFileWritable := Status;
End;

Function TFileWriter.IsFileGood(): Boolean;
Begin
    Status := False;
    If Not FileExists(FileName) Or Not IsFileTxt() Or Not IsFileWritable() Then
        Status := False
    Else
        Status := True;
    IsFileGood := Status;
End;

Procedure TFileWriter.SetFileName(FileName: String);
Begin
    Self.FileName := FileName;
    Assign(OutFile, Self.FileName);
End;

Procedure TFileWriter.OutputArray(Arr: TArrayOfInt; Const SIZE: Integer);
Var
    I: Integer;
Begin
    Try
        Rewrite(OutFile);
        Writeln(OutFile, '��������� ������:');
        For I := 1 To SIZE Do
            Write(OutFile, Arr[I - 1], ' ');
        Writeln(OutFile);
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
End;

End.
