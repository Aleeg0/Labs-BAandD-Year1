Unit BufferHandler;

Interface

Uses System.SysUtils;

Type

    TTypes = (TpInteger, TpUInteger, TpUReal, TpString);

    TBufferHandler = Class
    Private
        FEditText: String;
    Public
        Function CountSymbol(Const Symbol: Char): Integer;
        Function CheckInput(Const InputType: TTypes): Boolean;
        Function CheckRange(Const MIN, MAX; Const InputType: TTypes): Boolean;
        Function CheckPrecision(Const InputType: TTypes): Boolean;
        Procedure DeleteLeadingZeros(Const InputType: TTypes);
        Property EditText: String Read FEditText Write FEditText;
    End;

Implementation

{ TBufferHandler }

Function TBufferHandler.CheckInput(Const InputType: TTypes): Boolean;

Const
    GOOD_KEYS: Set Of Char = ['0' .. '9'];

Var
    Status: Boolean;
    I: Integer;
    CountOfMinuses: Integer;
    CountOfCommas: Integer;
Begin
    Status := True;
    Case InputType Of
        TpInteger:
            Begin
                CountOfMinuses := CountSymbol('-');
                If (CountOfMinuses = 0) Then
                Begin
                    For I := Low(FEditText) To High(FEditText) Do
                        If Status And Not(FEditText[I] In GOOD_KEYS) Then
                            Status := False;
                End
                Else
                    If (CountOfMinuses = 1) Then
                    Begin
                        For I := 2 To High(FEditText) Do
                            If Status And Not(FEditText[I] In GOOD_KEYS) Then
                                Status := False;
                    End
                    Else
                        Status := False;
            End;
        TpUInteger:
            Begin
                For I := Low(FEditText) To High(FEditText) Do
                    If Status And Not(FEditText[I] In GOOD_KEYS) Then
                        Status := False;
            End;
        TpUReal:
            Begin
                CountOfMinuses := CountSymbol('-');
                CountOfCommas := CountSymbol(',');
                If (CountOfMinuses = 0) And (CountOfCommas = 0) Then
                Begin
                    For I := 1 To High(FEditText) Do
                        If Status And Not((FEditText[I] In GOOD_KEYS)) Then
                            Status := False;
                End
                Else
                    If (CountOfMinuses = 0) And (CountOfCommas = 1) Then
                    Begin
                        For I := 1 To High(FEditText) Do
                            If Status And
                                Not((FEditText[I] In GOOD_KEYS) Or
                                (FEditText[I] = ',')) Then
                                Status := False;
                        If Status And (Length(FEditText) < 3) Then
                            Status := False;
                        I := Pos(',', FEditText);
                        If (I - 1 < 1) Or (I + 1 > Length(FEditText)) Then
                            Status := False;
                        If Status And (Not(FEditText[I - 1] In Good_KEYS) Or
                            Not(FEditText[I + 1] In Good_KEYS)) Then
                            Status := False;
                    End
                    Else
                        Status := False;
            End;
        TpString:
            Begin
                // why?
            End;
    End;
    CheckInput := Status;
End;

Function TBufferHandler.CheckPrecision(Const InputType: TTypes): Boolean;
Var
    IsGood: Boolean;
    I: Integer;
Begin
    IsGood := True;
    Case InputType Of
        TpUReal:
            Begin
                I := Pos(',', FEditText);
                If (I > 0) And (Length(FeditText) > (I + 2)) Then
                    IsGood := False;
            End;
    End;
    CheckPrecision := IsGood;
End;

Function TBufferHandler.CheckRange(Const MIN, MAX;
    Const InputType: TTypes): Boolean;
Var
    IsGood: Boolean;
Begin
    IsGood := True;
    Case InputType Of
        TpInteger:
            Begin
                Var
                    Number: Integer;
                Number := StrToInt(FEditText);
                If (Number < Integer(MIN)) Or (Integer(MAX) < Number) Then
                    IsGood := False;
            End;
        TpUInteger:
            Begin
                Var
                    Number: UInt32;
                Number := StrToUInt(FEditText);
                If (Number < Uint32(MIN)) Or (UInt32(MAX) < Number) Then
                    IsGood := False;
            End;
        TpUReal:
            Begin
                // так нельзя, но можно, если осторожно :)
                Var
                    Number: Real;
                Number := StrToFloat(FEditText);
                If (Number < Real(MIN)) Or (Real(MAX) < Number) Then
                    IsGood := False;
            End;
        TpString:
            // ахах ну это тип прикол
            ;
    Else
        IsGood := False;
    End;
    CheckRange := IsGood;
End;

Function TBufferHandler.CountSymbol(Const Symbol: Char): Integer;

Var
    I: Integer;
    Count: Integer;
Begin
    Count := 0;
    For I := 1 To Length(FEditText) Do
        If FEditText[I] = Symbol Then
            Inc(Count);
    CountSymbol := Count;
End;

Procedure TBufferHandler.DeleteLeadingZeros(Const InputType: TTypes);
Begin
    Case InputType Of
        TpInteger:
            Begin
                If CountSymbol('-') = 1 Then
                    While (Length(FEditText) > 1) And (FEditText[2] = '0') Do
                        Delete(FEditText, 2, 1)
                Else
                    While (Length(FEditText) > 0) And (FEditText[1] = '0') Do
                        Delete(FEditText, 1, 1);
            End;
        TpUInteger:
            While (Length(FEditText) > 0) And (FEditText[1] = '0') Do
                Delete(FEditText, 1, 1);
        TpUReal:
            Begin
                If (CountSymbol(',') = 1) Then
                Begin
                    While (Length(FEditText) > 2) And (FEditText[1] = '0') Do
                        Delete(FEditText, 1, 1);
                End
                Else
                Begin
                    While (Length(FEditText) > 1) And (FEditText[1] = '0') Do
                        Delete(FEditText, 1, 1);
                End;
            End;
    End;

End;

End.
