Program Exercise2;

Uses
    System.SysUtils;

Var
    N: Integer;
    Sum: Integer;
    NumberInLoop: Integer;
    // Low numbers for loops
    Low: Integer;
    High: Integer;
    // Flag for end loop for inputted symbols
    GoodFlag: Boolean = False;

Begin
    // initialization
    N := 0;
    Sum := 0;
    NumberInLoop := 1;
    Low := 1;
    High := 0;
    // output the task
    Writeln('Calculate the sum using the formula (-1)^i * 2^i:');
    Writeln;
    // loop for check inputted symbols
    Repeat
        Try
            // input
            Writeln('Enter n:');
            Readln(N);
            If N < 1 Then
                Writeln('N cannot be less than 1!!! Try again.')
            Else // to exit the loop if user entered correct symbols
                GoodFlag := True;
        Except
            Begin
                Writeln('Invalid numeric input!!! Try again');
            End;
        End;
    Until (GoodFlag);
    // main block
    High := N;
    For Low := 1 To High Do
    Begin
        NumberInLoop := NumberInLoop * 2;
        If Low Mod 2 <> 0 Then
            Sum := Sum - NumberInLoop
        Else
            Sum := Sum + NumberInLoop;
    End;
    // output
    Writeln('Sum equal ', Sum);
    Writeln;
    // End of program
    Writeln('Press Enter to exit...');
    Readln;

End.
