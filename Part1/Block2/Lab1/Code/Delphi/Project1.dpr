Program Exercise1;

Uses
    System.SysUtils;

Var
    I, N: Integer;
    A, B, C, CurrentSquare, HighestSquare: Real;
    P: Real; // half-perimeter
    IsCorrect: Boolean;

Begin
    // initialization
    A := 0.0;
    B := 0.0;
    C := 0.0;
    CurrentSquare := -1.0;
    HighestSquare := 1.0;
    P := 0.0;
    IsCorrect := False;
    Writeln('The program finding a triangle with the highest square.'#13#10);
    // make sure that user enter correct size
    Repeat
        Try
            Writeln('Enter how many triangles: ');
            Readln(N);
            If N < 1.0 Then
                Writeln('Entering number cannot be less than 1!!! Try again.')
            Else
                IsCorrect := True;
        Except
            Writeln('Invalid numeric type!!! Try again.');
        End;
    Until IsCorrect;
    // input sides of triangles
    For I := 1 To N Do
    Begin
        Repeat
            // inputting first side
            IsCorrect := False;
            Repeat
                Try
                    Writeln('Enter first side of triangle number ', I, ': ');
                    Readln(A);
                    If (A < 0.0) Or (A = 0.0) Then
                        Writeln('Side cannot be less than 0!!! Try again.')
                    Else
                        IsCorrect := True;
                Except
                    Writeln('Invalid numeric type!!! Try again.');
                End;
            Until IsCorrect;
            // inputting second side
            IsCorrect := False;
            Repeat
                Try
                    Writeln('Enter second side of triangle number ', I, ': ');
                    Readln(B);
                    If (B < 0) Or (B = 0) Then
                        Writeln('Side cannot be less than 0!!! Try again.')
                    Else
                        IsCorrect := True;
                Except
                    Writeln('Invalid numeric type!!! Try again.');
                End;
            Until IsCorrect;
            // inputting third side
            IsCorrect := False;
            Repeat
                Try
                    Writeln('Enter third side of triangle number ', I, ': ');
                    Readln(C);
                    If (C < 0.0) Or (C = 0.0) Then
                        Writeln('Side cannot be less than 0!!! Try again.')
                    Else
                        IsCorrect := True;
                Except
                    Writeln('Invalid numeric type!!! Try again.');
                End;
            Until IsCorrect;
            // check the triangle for correctness
            If (A + B > C) And (A + C > B) And (B + C > A) Then
                IsCorrect := True
            Else
            Begin
                Writeln('Triangle with sides ', A:5:3, ' ', B:5:3, ' ', C:5:3,
                    ' does'#39, 't exist.');
                IsCorrect := False;
            End;
        Until IsCorrect;
        // making counts
        P := (A + B + C) / 2.0;
        CurrentSquare := Sqrt(P * (P - A) * (P - B) * (P - C));
        If CurrentSquare > HighestSquare Then
            HighestSquare := CurrentSquare;
    End;
    // ouput
    Writeln('The best triangle has square equal ', HighestSquare:5:3);
    // freeze console
    Writeln('Press enter to exit...');
    Readln;

End.
