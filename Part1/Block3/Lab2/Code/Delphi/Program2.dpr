Program Program2;

{$APPTYPE CONSOLE}
{$R *.res}

Uses
    System.SysUtils;

Const
    COUNT_SYMBOLS : Integer = 255;
    KEY_SYMBOLS: Set Of Char = ['[', ']', '{', '}', '(', ')', '+', '-', '*',
        '/', '%'];

Type
    TSet = Set Of Char;

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
        Procedure OutputSet(Set1: TSet); Virtual; Abstract;
    End;

    // class ConsoleWriter
Type
    TConsoleWriter = Class(TWriter)
    Public
        Procedure OutputSet(Set1: TSet); Override;
    End;

Procedure TConsoleWriter.OutputSet(Set1: TSet);
Var
    I: Integer;
Begin
    Writeln('Function found this symbols in the inputted string.');
    For I := 0 To COUNT_SYMBOLS Do
        If Chr(I) In Set1 Then
            Write(Chr(I), ' ');
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
        Procedure OutputSet(Set1: TSet); Override;
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

Procedure TFileWriter.OutputSet(Set1: TSet);
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
            Writeln(OutFile,
                'Function found this symbols in the inputted string.');
            For I := 0 To COUNT_SYMBOLS Do
                If Chr(I) In Set1 Then
                    Write(OutFile, Chr(I), ' ');
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

Function FindSymbols(Str: String): TSet;
Var
    I, Size, CurCode: Integer;
    Answer: TSet;
    CurChar: Char;
Begin
    Answer := [];
    Size := Length(Str);
    For I := 1 To Size Do
    Begin
        CurChar := Str[I];
        CurCode := Ord(CurChar);
        If (CurChar In KEY_SYMBOLS) Then
            Answer := Answer + [CurChar]
            // 48 - code of '0'
            // 57 - code of '9'
        Else If (47 < CurCode) And (CurCode < 58) Then
        Begin
            Dec(CurCode, 48);
            If Curcode Mod 2 = 0 Then
                Answer := Answer + [CurChar];
        End;
    End;
    Result := Answer;
End;

Procedure InputTask();
Var
    I: Integer;
Begin
    Writeln('This program finding the symbols in the string, which you', #39,
        'll input.', #13#10, 'Symbols: ');
    For I := 0 To COUNT_SYMBOLS Do
        If Chr(I) In KEY_SYMBOLS Then
            Write(Chr(I), ' ');
    Writeln(#13#10, 'And digits that divided without remainder by 2.');
End;

Var
    Reader1: TReader;
    Writer1: TWriter;
    Answer: TSet;

Begin
    InputTask();
    Reader1 := InputMethod();
    Answer := FindSymbols(Reader1.InputString());
    Writer1 := OutputMethod();
    Writer1.OutputSet(Answer);
    // free memory
    Reader1 := Nil;
    Writer1 := Nil;
    Readln;

End.
