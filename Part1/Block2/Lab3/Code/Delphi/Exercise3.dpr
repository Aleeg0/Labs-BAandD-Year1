Program Exercise3;

Uses
    System.SysUtils;

Const
    MIN_MAX_ORDER = 2;

Type
    MatrixType = Array Of Array Of Real;

Procedure InitializationMatrix(Var Matrix: MatrixType; Const N: Integer);
Var
    I: Integer;
Begin
    SetLength(Matrix, N + 1, N + 1);
End;

Procedure Free(Var Matrix: MatrixType);
Begin
    Matrix := Nil;
End;

Function InputMethod(): Boolean;
Var
    IsCorrect: Boolean;
    Choice: String;
Begin
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
            Result := True;
        End
        Else If Choice = 'file' Then
        Begin
            IsCorrect := True;
            Result := False;
        End
        Else
            Writeln('The word ', Choice, ' don', #39,
                't match any of method to input the data.');
    Until IsCorrect;
End;

Function InputSizeOfMatrixFromConsole(): Integer;
Var
    IsCorrect: Boolean;
    N: Integer;
Begin
    N := 0;
    // asking for Size of matrix
    Repeat
        IsCorrect := False;
        Try
            Writeln('Enter the matrix order:');
            Readln(N);
            IsCorrect := True;
        Except
            Writeln('Invalid type. Try again.');
        End;
        If (N < MIN_MAX_ORDER) And IsCorrect Then
        Begin
            Writeln('Matrix order cannot be less than ', MIN_MAX_ORDER, '.');
            IsCorrect := False;
        End;
    Until IsCorrect;
    N := N - 1;
    Result := N;
End;

Function InputElementsOfMatrixFromConsole(Const N: Integer): MatrixType;
Var
    IsCorrect: Boolean;
    I: Integer;
    J: Integer;
    Matrix: MatrixType;
Begin
    InitializationMatrix(Matrix, N);
    IsCorrect := False;
    For I := 0 To N Do
    Begin
        For J := 0 To N Do
        Begin
            IsCorrect := False;
            Repeat
                Try
                    Writeln('Enter a', I + 1, J + 1, ':');
                    Readln(Matrix[I][J]);
                    IsCorrect := True;
                Except
                    Writeln('Invalid type! Try again.');
                End;
            Until IsCorrect;
        End;
    End;
    Result := Matrix;
End;

Function IsFileTxt(Var FileName: String): Boolean;
Var
    FileType: String;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Result := True
    Else
        Result := False;
End;

Function IsFileReadable(Var InFile: TextFile): Boolean;
Begin
    Try
        Reset(InFile);
        Result := True;
    Except
        Result := False;
    End;
    CloseFile(InFile);
End;

Function IsFileWritable(Var OutFile: TextFile): Boolean;
Begin
    Try
        Rewrite(OutFile);
        Result := True;
    Except
        Result := False;
    End;
    CloseFile(OutFile);
End;

Function InputReadFileName(): String;
Var
    FileName: String;
    IsCorrect: Boolean;
    InFile: TextFile;
Begin
    FileName := '';
    IsCorrect := False;
    Repeat
        IsCorrect := False;
        Assign(InFile, FileName);
        // Inputting name of file or path to the file including file
        Writeln('Enter the name of file in this directory or path to this file including name of file:');
        Readln(FileName);
        If (Not FileExists(FileName)) Then
            Writeln('This file or the path to the file is specified incorrectly or does not exist! Try again.')
        Else If (Not IsFileTxt(FileName)) Then
            Writeln('This file or path to the file isn', #39,
                't .txt! Try again.')
        Else If (Not IsFileReadable(InFile)) Then
            Writeln('The program can', #39, 't read this file!s Try again.')
        Else
            IsCorrect := True;
    Until IsCorrect;
    Result := FileName;
End;

Function InputWriteFileName(): String;
Var
    FileName: String;
    IsCorrect: Boolean;
    OutFile: TextFile;
Begin
    FileName := '';
    IsCorrect := False;
    Repeat
        Assign(OutFile, FileName);
        IsCorrect := False;
        // Inputting name of file or path to the file including file
        Writeln('Enter the name of file in this directory or path to this file including name of file:');
        Readln(FileName);
        If (Not FileExists(FileName)) Then
            Writeln('This file or the path to the file is specified incorrectly or does not exist! Try again.')
        Else If (Not IsFileTxt(FileName)) Then
            Writeln('This file or path to the file isn', #39,
                't .txt! Try again.')
        Else If (Not IsFileWritable(OutFile)) Then
            Writeln('The program can', #39,
                't write into this file! Try again.')
        Else
            IsCorrect := True;
    Until IsCorrect;
    Result := FileName;
End;

Function InputSizeOfMatrixFromFile(Var InFile: TextFile): Integer;
Var
    IsCorrect: Boolean;
    N: Integer;
Begin
    N := 0;
    IsCorrect := False;
    Try
        Read(InFile, N);
        IsCorrect := True;
    Except
        Writeln('Invalid type. Check data in the file.');
    End;
    If IsCorrect And (N < MIN_MAX_ORDER) Then
    Begin
        Writeln('Matrix order cannot be less than ', MIN_MAX_ORDER, '.');
        N := 0;
    End;
    N := N - 1;
    Result := N;
End;

Function InputElementsOfMatrixFromFile(Var InFile: TextFile; Var N: Integer)
    : MatrixType;
Var
    I: Integer;
    J: Integer;
    Matrix: MatrixType;
Begin
    InitializationMatrix(Matrix, N);
    For I := 0 To N Do
    Begin
        For J := 0 To N Do
        Begin
            If N <> -1 Then
            Begin
                Try
                    Read(InFile, Matrix[I][J]);
                Except
                    Writeln('Invalid type! Try again.');
                    N := -1;
                End;
            End;
        End;
    End;
    Result := Matrix;
End;

Function IsAnotherFile(): Boolean;
Var
    IsCorrect: Boolean;
    Choice: String;
Begin
    IsCorrect := False;
    Choice := '';
    Writeln('Read error was detected in your file.', #13#10, 'This program can',
        #39, 't continue to read this file.');
    Repeat
        Writeln('Do you want to change file?(yes/no)');
        Readln(Choice);
        If Choice = 'yes' Then
        Begin
            IsCorrect := True;
            Result := True;
        End
        Else If Choice = 'no' Then
        Begin
            IsCorrect := True;
            Result := False;
        End
        Else
            Writeln('You input incorrect word! Try again.');
    Until IsCorrect;
End;

Procedure Input(Var Matrix: MatrixType; Var N: Integer);
Var
    FileName: String;
    InFile: TextFile;
    IsExit: Boolean;
Begin
    IsExit := False;
    FileName := '';
    If InputMethod() Then
    Begin
        // input size of matrix
        N := InputSizeOfMatrixFromConsole();
        // input elements of matrix
        Matrix := InputElementsOfMatrixFromConsole(N);
    End
    Else
    Begin
        Repeat
            FileName := InputReadFileName();
            AssignFile(InFile, FileName);
            Reset(InFile);
            // input size of matrix
            N := InputSizeOfMatrixFromFile(InFile);
            // input elements of matrix
            Matrix := InputElementsOfMatrixFromFile(InFile, N);
            If N <> -1 Then
                IsExit := True
            Else If Not IsAnotherFile() Then
                IsExit := True;
            CloseFile(InFile);
        Until IsExit;
    End;
End;

Function FindBestSum(Var Matrix: MatrixType; Const N: Integer): Real;
Var
    BestSum: Real;
    I: Integer;
    J: Integer;
Begin
    BestSum := 0.0;
    For I := 0 To N Do
    Begin
        For J := 0 To N Do
        Begin
            If (J < N) And ((Matrix[I][J] + Matrix[I][J + 1]) > BestSum) Then
                BestSum := Matrix[I][J] + Matrix[I][J + 1];
            If (I < N) And ((Matrix[I][J] + Matrix[I + 1][J]) > BestSum) Then
                BestSum := Matrix[I][J] + Matrix[I + 1][J];
        End;
    End;
    Result := BestSum;
End;

Function OutputMethod(): Boolean;
Var
    IsCorrect: Boolean;
    Choice: String;
Begin
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
            IsCorrect := True;
            Result := True;
        End
        Else If Choice = 'file' Then
        Begin
            IsCorrect := True;
            Result := False;
        End
        Else
            Writeln('The word ', Choice, ' don', #39,
                't match any of method to output the data.');
    Until IsCorrect;
End;

Procedure OutputConsole(Const Answer: Real);
Begin
    Writeln('The answer is ', Answer:6:3, '.');
End;

Procedure OutputFile(Const Answer: Real);
Var
    FileName: String;
    OutFile: TextFile;
Begin
    FileName := InputWriteFileName();
    Assign(OutFile, FileName);
    Rewrite(OutFile);
    Writeln(OutFile, 'The answer is ', Answer:6:3, '.');
    CloseFile(OutFile);
    Writeln('Answer has been written down successful.');
End;

Procedure Output(Const Answer: Real);
Begin
    If OutputMethod() Then
        OutputConsole(Answer)
    Else
        OutputFile(Answer);
End;

Procedure Main();
Var
    N: Integer;
    Answer: Real;
    Matrix: MatrixType;
Begin
    N := 0;
    Answer := 0.0;
    Input(Matrix, N);
    If N <> -1 Then
    Begin
        Answer := FindBestSum(Matrix, N);
        Output(Answer);
    End;
    Free(Matrix);
End;

Begin
    Main();
    // freeze console
    Writeln('Press enter to exit...');
    Readln;

End.
