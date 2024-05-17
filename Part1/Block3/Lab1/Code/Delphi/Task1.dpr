Program Task1;

{$APPTYPE CONSOLE}
{$R *.res}

Uses
    System.SysUtils;

// class reader
Type
    TReader = Class
    Public
        Function InputString(): String; Virtual; Abstract;
        Procedure EmptyStringMessage(); Virtual;
    End;

Procedure TReader.EmptyStringMessage();
Begin
    Writeln('Your string Empty! Try again.');
End;

// class consoleReader
Type
    TConsoleReader = Class(TReader)
    Public
        Function InputString(): String; Override;
    End;

Function TConsoleReader.InputString(): String;
Var
    InputtedString: String;
    IsCorrect: Boolean;
Begin
    IsCorrect := False;
    InputtedString := '';
    Repeat
        Writeln('Enter string:');
        Readln(InputtedString);
        If (InputtedString <> '') Then
            IsCorrect := True
        Else
            EmptyStringMessage();
    Until IsCorrect;
    Result := InputtedString;
End;

// class FileReader
Type
    TFileReader = Class(TReader)
    Private
        FileName: String;
        InFile: TextFile;
        FileStatus: Boolean;
    Public
        Function InputString(): String; Override;
        Function IsFileGood(): Boolean;
        Function IsFileTxt(): Boolean;
        Function IsFileReadable(): Boolean;
    End;

Function TFileReader.IsFileTxt(): Boolean;
Var
    FileType: String;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        FileStatus := True
    Else
        FileStatus := False;
    Result := FileStatus;
End;

Function TFileReader.IsFileReadable(): Boolean;
Begin
    Try
        Reset(InFile);
        FileStatus := True;
    Except
        FileStatus := False;
    End;
    CloseFile(InFile);
    Result := FileStatus;
End;

Function TFileReader.IsFileGood(): Boolean;
Begin
    FileStatus := False;
    If (Not FileExists(FileName)) Then
        Writeln('This file or the path to the file is specified incorrectly or does not exist! Try again.')
    Else If (Not IsFileTxt()) Then
        Writeln('This file or path to the file isn', #39, 't .txt! Try again.')
    Else If (Not IsFileReadable()) Then
        Writeln('The program can', #39, 't read this file! Try again.')
    Else
        FileStatus := True;
    Result := FileStatus;
End;

Function TFileReader.InputString: String;
Var
    InputtedString: String;
    IsCorrect: Boolean;
Begin
    IsCorrect := False;
    Repeat
        Writeln('Enter the name of file in this directory or path to this file including name of file:');
        Readln(FileName);
        AssignFile(InFile, FileName);
        If IsFileGood() Then
        Begin
            Reset(InFile);
            If Not Eof(InFile) Then
            Begin
                Read(InFile, InputtedString);
                IsCorrect := True;
            End
            Else
                EmptyStringMessage();
            CloseFile(InFile);
        End;
    Until IsCorrect;
    Result := InputtedString;
End;

// class Writer
Type
    TWriter = Class
    Public
        Procedure OutputString(Str: String); Virtual; Abstract;
    End;

    // class ConsoleWriter
Type
    TConsoleWriter = Class(TWriter)
    Public
        Procedure OutputString(Str: String); Override;
    End;

Procedure TConsoleWriter.OutputString(Str: String);
Begin
    Writeln('The number in the string is ', Str, '.');
End;

// class FileWriter
Type
    TFileWriter = Class(TWriter)
    Private
        OutFile: TextFile;
        FileName: String;
        FileStatus: Boolean;
    Public
        Procedure OutputString(Str: String); Override;
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
    Result := FileStatus;
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
    Result := FileStatus;
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
    Result := FileStatus;
End;

Procedure TFileWriter.OutputString(Str: String);
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := False;
    Repeat
        Writeln('Enter the name of file in this directory or path to this file including name of file:');
        Readln(FileName);
        AssignFile(OutFile, FileName);
        If IsFileGood() Then
        Begin
            Rewrite(OutFile);
            Writeln(OutFile, 'The number in the string is ', Str, '.');
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
    Result := Reader1;
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
    Result := Writer1;
End;

Function FindNumberInString(Str: String): String;
Var
    IsNumber, WasNumber: Boolean;
    I, Size: Integer;
    Number: String;
Begin
    IsNumber := False;
    WasNumber := False;
    Number := '';
    Size := Str.Length;
    For I := 1 To Size Do
    Begin
        If (Not WasNumber) And ((Str[I] = '+') Or (Str[I] = '-')) Then
        Begin
            IsNumber := True;
            Number := '';
            Number := Number + Str[I];
        End
        Else If (IsNumber) And (47 < Ord(Str[I])) And (Ord(Str[I]) < 58) Then
        Begin
            Number := Number + Str[I];
            WasNumber := True;
        End
        Else If IsNumber And WasNumber Then
        Begin
            IsNumber := False;
        End
        Else If Not WasNumber Then
            IsNumber := False;
    End;
    If Not WasNumber Then
        Number := '';
    Result := Number;
End;

Var
    Reader1: TReader;
    Writer1: TWriter;
    Answer: String;

Begin
    Reader1 := InputMethod();
    Answer := FindNumberInString(Reader1.InputString());
    Writer1 := OutputMethod();
    Writer1.OutputString(Answer);
    // free memory
    Reader1 := Nil;
    Writer1 := Nil;
    Readln;

End.
