Program Exercise4;

Uses
    System.SysUtils;

// initialization
Var
    N: Integer = 0;
    List1: Array Of Integer;
    List2: Array Of Integer;
    Number: Integer = 0;
    // Low numbers for loops
    I: Integer;
    // Flag for end loop for inputted symbols
    GoodFlag: Boolean = False;

Begin
    // output the task
    Write('Program  outputs a new array, by using data entered');
    Writeln('array, according to this formula b[k]=2 * a[k]+k.');
    Writeln;
    // loop for check inputted size
    Repeat
        Try
            // input
            Writeln('Enter size of array: ');
            Readln(N);
            If N < 1 Then
                Raise Exception.Create('N cannot be less than 1');
            GoodFlag := True; // to exit the loop if user entered correct size
        Except
            On E: Exception Do
            Begin
                Write(E.Message);
                Writeln('!!! Try again.');
            End;
        End;
    Until (GoodFlag);
    // memory allocation of the first array
    SetLength(List1, N);
    // output more info
    Writeln('Enter numbers, which you want to add in array:');
    // loop for check inputted numbers in array
    GoodFlag := False;
    Repeat
        Try
            For I := 0 To N - 1 Do
            Begin
                Writeln('Enter ', I + 1, ' number: ');
                Readln(Number);
                List1[I] := Number;
            End;
            GoodFlag := True; // to exit the loop if user entered correct size
        Except
            On E: Exception Do
            Begin
                Write(E.Message);
                Writeln('!!! Try again.');
            End;
        End;
    Until (GoodFlag);
    // main block
    SetLength(List2, N);
    For I := 0 To N - 1 Do
    Begin
        List2[I] := List1[I] * 2 + I + 1;
    End;
    // output
    Writeln('Array after transformation:');
    For I := 0 To N - 1 Do
    Begin
        Write('Number ', I + 1);
        Writeln(' in array: ', List2[I]);
    End;
    // free memory
    List1 := Nil;
    List2 := Nil;
    // freeze console
    Writeln('Press enter to exit...');
    Readln;

End.
