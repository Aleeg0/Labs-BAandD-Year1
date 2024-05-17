Program Program3;

{$APPTYPE CONSOLE}
{$R *.res}

Uses
    System.SysUtils;

Const
    MIN_SIZE: Integer = 2;

Type
    TArray = Array Of Integer;

    // class reader
Type
    TReader = Class
    Public
        Function InputSize(): Integer; Virtual; Abstract;
        Function InputArray(Const SIZE: Integer): TArray; Virtual; Abstract;
        Procedure InvalidTypeMessage();
    End;

Procedure TReader.InvalidTypeMessage();
Begin
    Writeln('Invalid type! Try again.');
End;

// class consoleReader
Type
    TConsoleReader = Class(TReader)
    Public
        Function InputSize(): Integer; Override;
        Function InputArray(Const SIZE: Integer): TArray; Override;
    End;

Function TConsoleReader.InputSize(): Integer;
Var
    Size: Integer;
    IsCorrect: Boolean;
Begin
    IsCorrect := False;
    Size := 0;
    Repeat
        Try
            Writeln('Enter size of array:');
            Readln(Size);
            IsCorrect := True;
        Except
            InvalidTypeMessage;
        End;
        If (Size < MIN_SIZE) Then
        Begin
            Writeln('Size of array cannot be less than ', MIN_SIZE, '.');
            IsCorrect := False;
        End;
    Until IsCorrect;
    InputSize := Size;
End;

Function TConsoleReader.InputArray(Const SIZE: Integer): TArray;
Var
    IsCorrect: Boolean;
    I: Integer;
    Arr: TArray;
Begin
    SetLength(Arr, SIZE);
    IsCorrect := False;
    For I := 1 To SIZE Do
    Begin
        IsCorrect := False;
        Repeat
            Try
                Writeln('Enter ', I, ' element:');
                Readln(Arr[I - 1]);
                IsCorrect := True;
            Except
                InvalidTypeMessage;
            End;
        Until IsCorrect;
    End;
    InputArray := Arr;
End;

// class FileReader
Type
    TFileReader = Class(TReader)
    Private
        FileName: String;
        InFile: TextFile;
        Status: Boolean;
        Function IsFileTxt(): Boolean;
        Function IsFileReadable(): Boolean;
    Public
        Function GetStatus(): Boolean;
        Procedure SetFileName();
        Function InputSize(): Integer; Override;
        Function InputArray(Const SIZE: Integer): TArray; Override;
        Function IsFileGood(): Boolean;
    End;

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
    Except
        Status := False;
    End;
    CloseFile(InFile);
    IsFileReadable := Status;
End;

Function TFileReader.IsFileGood(): Boolean;
Begin
    Status := False;
    If (Not FileExists(FileName)) Then
        Writeln('This file or the path to the file is specified incorrectly or does not exist! Try again.')
    Else If (Not IsFileTxt()) Then
        Writeln('This file or path to the file isn', #39, 't .txt! Try again.')
    Else If (Not IsFileReadable()) Then
        Writeln('The program can', #39, 't read this file! Try again.')
    Else
        Status := True;
    IsFileGood := Status;
End;

Procedure TFileReader.SetFileName;
Begin
    Repeat
        Writeln('Enter the name of file in this directory or path to this file including name of file:');
        Readln(FileName);
        AssignFile(InFile, FileName);
    Until IsFileGood();
End;

Function TFileReader.InputSize: Integer;
Var
    Size: Integer;
Begin
    Size := 0;
    Reset(InFile);
    Try
        Read(InFile, Size);
    Except
        Writeln('Invalid type. Check data in the file.');
        Status := False;
    End;
    If Size < MIN_SIZE Then
    Begin
        Writeln('Matrix order cannot be less than ', MIN_SIZE, '.');
        Status := False;
    End;
    CloseFile(InFile);
    InputSize := Size;
End;

Function TFileReader.InputArray(Const SIZE: Integer): TArray;
Var
    Arr: TArray;
    I: Integer;
Begin
    SetLength(Arr, SIZE);
    Reset(InFile);
    Read(InFile,I);
    For I := 1 To SIZE Do
    Begin
        If Status Then
        Try
            Read(InFile, Arr[I - 1]);
        Except
            Writeln('Invalid type. Check data in the file.');
            Status := False;
        End;
    End;
    CloseFile(InFile);
    InputArray := Arr;
End;

// class Writer
Type
    TWriter = Class
    Public
        Procedure OutputArray(Var Arr: TArray; Const SIZE: Integer);
            Virtual; Abstract;
    End;

    // class ConsoleWriter
Type
    TConsoleWriter = Class(TWriter)
    Public
        Procedure OutputArray(Var Arr: TArray; Const SIZE: Integer); Override;
    End;

Procedure TConsoleWriter.OutputArray(Var Arr: TArray; Const SIZE: Integer);
Var
    I: Integer;
Begin
    Writeln('Sorted array:');
    For I := 1 To SIZE Do
        Write(Arr[I - 1], ' ');
    Writeln;
End;

// class FileWriter
Type
    TFileWriter = Class(TWriter)
    Private
        OutFile: TextFile;
        FileName: String;
        FileStatus: Boolean;
    Public
        Procedure OutputArray(Var Arr: TArray; Const SIZE: Integer); Override;
        Function IsFileGood(): Boolean;
        Function IsFileTxt(): Boolean;
        Function IsFileWritable(): Boolean;
    End;

Function TFileWriter.IsFileTxt(): Boolean;
Var
    FileType: String;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        FileStatus := True
    Else
        FileStatus := False;
    IsFileTxt := FileStatus;
End;

Function TFileWriter.IsFileWritable(): Boolean;
Begin
    Try
        Rewrite(OutFile);
        FileStatus := True;
    Except
        FileStatus := False;
    End;
    CloseFile(OutFile);
    IsFileWritable := FileStatus;
End;

Function TFileWriter.IsFileGood(): Boolean;
Begin
    FileStatus := False;
    If (Not FileExists(FileName)) Then
        Writeln('This file or the path to the file is specified incorrectly or does not exist! Try again.')
    Else If (Not IsFileTxt()) Then
        Writeln('This file or path to the file isn', #39, 't .txt! Try again.')
    Else If (Not IsFileWritable()) Then
        Writeln('The program can', #39, 't write from this file! Try again.')
    Else
        FileStatus := True;
    IsFileGood := FileStatus;
End;

Procedure TFileWriter.OutputArray(Var Arr: TArray; Const SIZE: Integer);
Var
    IsCorrect: Boolean;
    I: Integer;
Begin
    IsCorrect := False;
    Repeat
        Writeln('Enter the name of file in this directory or path to this file including name of file:');
        Readln(FileName);
        AssignFile(OutFile, FileName);
        If IsFileGood() Then
        Begin
            Rewrite(OutFile);
            Writeln(OutFile, 'Sorted array:');
            For I := 1 To SIZE Do
                Write(OutFile, Arr[I - 1], ' ');
            Writeln(OutFile);
            Writeln('Answer has been wrote successfully.');
            IsCorrect := True;
            CloseFile(OutFile);
        End;
    Until IsCorrect;
End;

// other function

Function InputMethod(): TReader;
Var
    IsCorrect: Boolean;
    Choice: String;
    Reader1: TReader;
Begin
    Reader1 := Nil;
    IsCorrect := False;
    Choice := '';
    Writeln('The program works with console input or files.');
    Repeat
        Writeln('To use console enter ', #39, 'console', #39, '.', #13#10,
            'To use a file enter ', #39, 'file', #39, '.'#13#10,
            'Enter what type you want to use: ');
        Readln(Choice);
        If Choice = 'console' Then
        Begin
            IsCorrect := True;
            Reader1 := TConsoleReader.Create;
        End
        Else If Choice = 'file' Then
        Begin
            Reader1 := TFileReader.Create;
            IsCorrect := True;
        End
        Else
            Writeln('The word ', Choice, ' don', #39,
                't match any of method to input the data.');
    Until IsCorrect;
    InputMethod := Reader1;
End;

Function OutputMethod(): TWriter;
Var
    IsCorrect: Boolean;
    Choice: String;
    Writer1: TWriter;
Begin
    Writer1 := Nil;
    IsCorrect := False;
    Choice := '';
    Writeln('The program works with console output or files.');
    Repeat
        Writeln('To use console enter ', #39, 'console', #39, '.', #13#10,
            'To use a file enter ', #39, 'file', #39, '.'#13#10,
            'Enter what type you want to use: ');
        Readln(Choice);
        If Choice = 'console' Then
        Begin
            Writer1 := TConsoleWriter.Create;
            IsCorrect := True;
        End
        Else If Choice = 'file' Then
        Begin
            Writer1 := TFileWriter.Create;
            IsCorrect := True;
        End
        Else
            Writeln('The word ', Choice, ' don', #39,
                't match any of method to output the data.');
    Until IsCorrect;
    OutputMethod := Writer1;
End;

Procedure InputTask();
Begin
    Writeln('The program sorts array of integers.');
End;

// main functions for margesort

Function Min(First, Second: Integer): Integer;
Var
    MinNumber: Integer;
Begin
    If First < Second Then
        MinNumber := First
    Else
        MinNumber := Second;
    Min := MinNumber;
End;

Procedure Marge(Var Arr: TArray; Beg1, End1, Beg2, End2: Integer);
Var
    I, Left, Right, Size: Integer;
    CopyArr: TArray;
Begin
    Left := 0;
    Right := Beg2 - Beg1;
    Size := End2 - Beg1 + 1;
    SetLength(CopyArr, Size);
    For I := 1 To Size Do
        CopyArr[I - 1] := Arr[Beg1 + I - 1];
    I := beg1;
    while (i < beg1 + size) do
    begin
        if (left + beg1 > end1) Then
        Begin
            Arr[i] := copyArr[right];
            Inc(right);
        End
        else if (right + beg1 > end2) Then
        begin 
            Arr[i] := copyArr[left];
            Inc(Left);
        end
        else if (copyArr[left] < copyArr[right]) Then
        Begin
            arr[i] := copyArr[left];
            Inc(Left);
        End
        else 
        Begin
            arr[i] := copyArr[right];
            Inc(Right);
        End;
        inc(I);
    end;
End;

Procedure MargeSort(Var Arr: TArray; First, Last: Integer);
Var
    Step, J: Integer;
Begin
    Step := 1;
    While (Step < Last) Do
    Begin
        J := First;
        While (J < Last - Step) Do
        Begin
            Marge(Arr, J, J + Step - 1, J + Step, Min(J + Step * 2 - 1, Last - 1));
            J := J + Step * 2;
        End;
        Step := Step * 2;
    End;
End;

Var
    Reader1: TReader;
    FileReader1: TFileReader;
    Writer1: TWriter;
    SizeOfArray: Integer;
    Arr: TArray;
    IsCorrect: Boolean;

Begin
    Reader1 := Nil;
    Writer1 := Nil;
    FileReader1 := Nil;
    InputTask();
    Reader1 := InputMethod();
    isCorrect := False;
    If Reader1.ClassType = TFileReader Then
    Begin
        FileReader1 := Reader1 As TFileReader;
        Repeat
            FileReader1.SetFileName();
            SizeOfArray := FileReader1.InputSize();
            If FileReader1.GetStatus Then
                Arr := FileReader1.InputArray(SizeOfArray);
            If FileReader1.GetStatus Then
                IsCorrect := True
            Else
                Writeln('Read error was detected in your file.', #13#10,
                    'This program can', #39, 't continue to read this file.');
        Until IsCorrect;
    End
    Else
    Begin
        SizeOfArray := Reader1.InputSize();
        Arr := Reader1.InputArray(SizeOfArray);
    End;
    MargeSort(Arr,0,SizeOfArray);
    Writer1 := OutputMethod();
    Writer1.OutputArray(Arr, SizeOfArray);
    // free memory
    Reader1 := Nil;
    Writer1 := Nil;
    Readln;
End.
