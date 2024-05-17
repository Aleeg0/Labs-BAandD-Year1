Program Exercise2;

Uses
    System.SysUtils;

Const
    MaxK = 10000000;
    MinK = 1;
    MaxDigit = 9;
    MaxDigits = 10;

Var
    K: Integer;

Procedure Input(Var K: Integer);
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := false;
    Writeln('The program finds all natural numbers that are k times greater than the sum of their digits.');
    Repeat
        Try
            Writeln('Enter the number from ', MinK, ' to ', MaxK, '.');
            Readln(K);
        Except
            Begin
                Writeln('Invalid type! Try again.');
            End;
        End;
        If K < MinK Then
            Writeln('The entered number cannot be less than ', MinK,
                '! Try again.')
        Else If MaxK < K Then
            Writeln('The entered number cannot be more than ', MaxK,
                '! Try again.')
        Else
            IsCorrect := True;
    Until IsCorrect;
End;

Procedure Output(Var NaturalNumber: Integer);
Begin
    Write(NaturalNumber, ' ');
End;

Function DigitsSum(NaturalNumber: Integer): Integer;
Var
    Sum: Integer;
Begin
    Sum := 0;
    While NaturalNumber > 0 Do
    Begin
        Sum := Sum + NaturalNumber Mod 10;
        NaturalNumber := NaturalNumber Div 10;
    End;
    Result := Sum;
End;

Function FindMaxNumber(Const K: Integer): Integer;
Var
    MaxNumber: Integer;
    CountOfDigits: Integer;
Begin
    MaxNumber := 1;
    CountOfDigits := 1;
    While (CountOfDigits < MaxDigits) And
        ((K * MaxDigit * CountOfDigits) > MaxNumber) Do
    Begin
        MaxNumber := MaxNumber * 10;
        CountOfDigits := CountOFDigits + 1;
    End;
    MaxNumber := MaxNumber Div 10;
    Result := MaxNumber;
End;

Procedure FindNumber(Var K: Integer);
Var
    NaturalNumber: Integer;
    MaxNumber: Integer;
Begin
    NaturalNumber := K;
    MaxNumber := FindMaxNumber(K);
    While NaturalNumber < MaxNumber Do
    Begin
        If NaturalNumber = DigitsSum(NaturalNumber) * K Then
            Output(NaturalNumber);
        NaturalNumber := NaturalNumber + K;
    End;
End;

Begin
    K := 0;
    Input(K);
    FindNumber(K);
    //freeze console
    Writeln(#13#10,'Press enter to exit...');
    Readln;
End.
