Unit BackendUnit4_2;

Interface

Uses System.SysUtils;

Type
    TArray = Array Of Integer;

    TArraySorter = Class
    Private
        UserArray: TArray;
        Size: Integer;
        Procedure Swap(Var First, Second: Integer);
        Function Partition(Var Arr: TArray; First, Last: Integer): Integer;
    Public
        Constructor Create(Size: Integer);
        Procedure SetElementByIndex(Element, I: Integer);
        Function GetSize(): Integer;
        Procedure QuickSort(Var Arr: TArray; First, Last: Integer);
        Function GetUserArray(): TArray;
        Function GetArray(): TArray;

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
        Function InputArray(Const SIZE: Integer): TArray;
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
        Procedure OutputArray(Arr: TArray; Const SIZE: Integer);
        Function IsFileGood(): Boolean;
    End;

    TBufferHandler = Class
    Private
        FStatus: Boolean;
        FEditText: String;
        Function GetStatus(): Boolean;
    Public
        Property Status: Boolean Read GetStatus;
        Property EditText: String Write FEditText;
    End;

Var
    ArraySorter: TArraySorter;

Implementation

{ TArraySorting }

Constructor TArraySorter.Create(Size: Integer);
Begin
    Self.Size := Size;
    SetLength(UserArray, Size);
End;

Function TArraySorter.GetSize: Integer;
Begin
    GetSize := Size;
End;

Function TArraySorter.GetArray: TArray;
Begin
    GetArray := UserArray;
End;

Function TArraySorter.GetUserArray: TArray;
Begin
    GetUserArray := UserArray;
End;

Function TArraySorter.Partition(Var Arr: TArray; First, Last: Integer): Integer;
Var
    Pivot, I, J: Integer;
Begin
    Pivot := Arr[Last];
    I := First - 1;
    For J := First To Last Do
    Begin
        If Arr[J] < Pivot Then
        Begin
            Inc(I);
            Swap(Arr[I], Arr[J]);
        End;
    End;
    Inc(I);
    Swap(Arr[I], Arr[Last]);
    Partition := I;
End;

Procedure TArraySorter.QuickSort(Var Arr: TArray; First, Last: Integer);
Var
    Pivot: Integer;
Begin
    If Last <= First Then
        Exit(); // basic case
    Pivot := Partition(Arr, First, Last);
    QuickSort(Arr, First, Pivot - 1);
    QuickSort(Arr, Pivot + 1, Last);
End;

Procedure TArraySorter.SetElementByIndex(Element, I: Integer);
Begin
    UserArray[I] := Element;
End;

Procedure TArraySorter.Swap(Var First, Second: Integer);
Var
    Temp: Integer;
Begin
    Temp := First;
    First := Second;
    Second := Temp;
End;

{ TFileReader }

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
    Except
        Status := False;
    End;
    IsFileReadable := Status;
End;

Function TFileReader.IsFileGood(): Boolean;
Begin
    Status := False;
    If Not FileExists(FileName) Or Not IsFileTxt() Or Not IsFileReadable() Then
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

Function TFileReader.InputArray(Const SIZE: Integer): TArray;
Const
    MIN_NUMBER: Integer = -99999;
    MAX_NUMBER: Integer = 99999;
Var
    IsCorrect: Boolean;
    Arr: TArray;
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

{ TFileWriter }

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
        Rewrite(OutFile);
        Status := True;
        CloseFile(OutFile);
    Except
        Status := False;
    End;
    IsFileWritable := Status;
End;

Function TFileWriter.IsFileGood(): Boolean;
Begin
    If Not FileExists(FileName) And Not IsFileTxt() Or Not IsFileWritable() Then
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

Procedure TFileWriter.OutputArray(Arr: TArray; Const SIZE: Integer);
Var
    I: Integer;
Begin
    Try
        Rewrite(OutFile);
        Writeln(OutFile, 'Изменённый массив:');
        For I := 1 To SIZE Do
            Write(OutFile, Arr[I - 1], ' ');
        Writeln(OutFile);
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
End;

{ TBufferHandler }

Function TBufferHandler.GetStatus(): Boolean;
Const
    GOOD_KEYS: Set Of Char = ['0' .. '9'];
Var
    I: Integer;
Begin
    FStatus := True;
    For I := Low(FEditText) To High(FEditText) Do
        If FStatus And Not(FEditText[I] In GOOD_KEYS) Then
            FStatus := False;
    GetStatus := FStatus;
End;

End.
