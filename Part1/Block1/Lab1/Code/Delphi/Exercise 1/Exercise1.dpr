Program Exercise1;

Uses
    System.SysUtils, Math;

// initialization
Var
    Num1: Real = 0;
    Num2: Real = 0;
    ArithmeticAvg: Real = 0;
    GeometricAvg: Real = 0;
    GoodFlag: Boolean = False;

Begin
    // output the task
    Writeln('  The program is proving that arithmetic average of two unsigned');
    Writeln('double numbers bigger or equal than geometric average of this numbers.');
    Writeln;
    // loop for check inputted symbols
    Repeat
        Try
            Begin
                // input in console
                Writeln('Enter first unsigned double number:');
                Readln(Num1);
                If Num1 < 0 Then
                    Raise Exception.Create
                        ('Entering number cannot be less than 1!!!');
                Writeln('Enter second unsigned double number:');
                Readln(Num2);
                If Num2 < 0 Then
                    Raise Exception.Create
                        ('Entering number cannot be less than 1!!!');
                // to exit the loop if user entered correct symbols
                GoodFlag := True;
            End;
        Except
            On E: Exception Do
            Begin
                Write(E.Message);
                Writeln(' Try again.');
                Writeln;
            End;
        End;
    Until (GoodFlag);
    // main block
    ArithmeticAvg := (Num1 + Num2) / 2;
    GeometricAvg := Sqrt(Num1 * Num2);
    // ouput console
    Writeln;
    Writeln('Arithmetic average: ', ArithmeticAvg:1:4);
    Writeln('Geometric average: ', GeometricAvg:1:4);
    If ArithmeticAvg = GeometricAvg Then
        Writeln('Arithmetic average = Geometric average')
    Else
        Writeln('Arithmetic average > Geometric average');
    // freeze console
    Writeln('Press Enter to exit...');
    Readln;

End.
