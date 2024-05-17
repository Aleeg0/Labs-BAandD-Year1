Unit EdgeUnit;

Interface

Type
    TEdge = Record
        A: Integer;
        B: Integer;
        Weight: Integer;
    End;

Function EqualityComparer(Var Item1, Item2: TEdge): Boolean;
Function Comparer(Var Item1, Item2: TEdge): Integer;

Implementation

Function EqualityComparer(Var Item1, Item2: TEdge): Boolean;
Begin
    EqualityComparer := (Item1.A = Item2.A) And (Item1.B = Item2.B);
End;

Function Comparer(Var Item1, Item2: TEdge): Integer;
Var
    Answer: Integer;
Begin
    If Item1.A > Item2.A Then
        Answer := 1
    Else If Item1.A = Item2.A Then
    begin
        if Item1.Weight > Item2.Weight then
            Answer := 1
        else if Item1.Weight > Item2.Weight then
            Answer := 0
        else
            Answer := -1;
    end
    else
        Answer := -1;
    Comparer := Answer;
End;

End.
