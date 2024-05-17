Unit LinkedList;

Interface

Type
    // comparator type
    TComparer<T> = Function(Var Item1, Item2: T): Integer;

    TEqualityComparer<T> = Function(Var Item1, Item2: T): Boolean;

    // Array of T
    TArray<T> = Array Of T;

    TPair<T1, T2> = Record
        Key: T1;
        Value: T2;
    End;

    TTriplet<T1, T2, T3> = Record
        Value1: T1;
        Value2: T2;
        Value3: T3;
    End;

    // linked list
    TList<T> = Class
    Private
        FCound: UInt32;

    Type
        PtrNode = ^TNode;

        TNode = Record
            FNext: PtrNode;
            FValue: T;
        End;

    Var
        FHead: PtrNode;
        FTail: PtrNode;
        FCount: UInt32;
        FComparer: TComparer<T>;
        FEqualityComparer: TEqualityComparer<T>;
        Function GetItem(Index: Integer): T;
        // default comparator
        // Class Function DefaultComparator(Var Item1, Item2: T): Integer; Static;
        // дефолтный EqualityComparer
        Class Function DefaultEqualityComparer(Var Item1, Item2: T)
            : Boolean; Static;
    Public
        Constructor Create();
        Property Count: UInt32 Read FCount;
        // Conversion by index
        Property Item[Index: Integer]: T Read GetItem; Default;
        // Add equal comparator
        Property Comparer: TComparer<T> Read FComparer Write FComparer;
        // свойство EqualityComparer
        Property EqualityComparer: TEqualityComparer<T> Read FEqualityComparer
            Write FEqualityComparer;
        // Adding new item to the end of list
        // скорость добавления O(1)
        Procedure PushBack(Value: T);
        // Добавление в соответствии с сортировкой
        // скорость добавления O(N)
        Procedure Add(Value: T);
        // Добавляем элемент с проверкой на повторность
        // Возвращает True, если элемент был добавлен
        // скорость добавления O(2N)
        Function TryAdd(Value: T): Boolean;
        // удаление
        Procedure Delete(Value: T);
        // поиск по значению одного элемента => индекс
        Function FindByValue(Value: T): Integer;
        // поиск по значению всех элементов => массив элементов
        Function FindAllByValue(Value: T): TArray<T>;
        // clear list
        Procedure Clear();
        // interpretate list to basic array
        Function ToArray(): TArray<T>;
    End;

Implementation

{ TList<T> }

Procedure TList<T>.PushBack(Value: T);
Var
    Cur: PtrNode;
    TempValue: T;
Begin
    If FHead = Nil Then
    Begin
        New(FHead);
        FHead.FNext := Nil;
        FHead.FValue := Value;
        FTail := FHead;
    End
    Else
    Begin
        New(FTail.FNext);
        FTail := FTail.FNext;
        FTail.FNext := Nil;
        FTail.FValue := Value;
    End;
    Inc(FCount);
End;

Procedure TList<T>.Add(Value: T);
Var
    CurNode, NewNode: PtrNode;
    ComparerResult: Integer;
Begin
    // если список пустой
    If FHead = Nil Then
    Begin
        New(FHead);
        FHead.FNext := Nil;
        FHead.FValue := Value;
        FTail := FHead;
    End
    Else // если же не пустой
    Begin
        CurNode := FHead;
        // если новый элемент меньше текущего первого в списке
        If FComparer(Value, CurNode.FValue) = -1 Then
        Begin
            New(NewNode);
            NewNode.FValue := Value;
            NewNode.FNext := CurNode;
            FHead := NewNode;
        End
        Else // если нет, то проходимся по остальным элементам
        Begin
            While (CurNode.FNext <> Nil) And
                (FComparer(Value, CurNode.FNext.FValue) > -1) Do
                CurNode := CurNode.FNext;
            // если мы пришли в конец то добавляем
            If CurNode.FNext = Nil Then
            Begin
                New(FTail.FNext);
                FTail := FTail.FNext;
                FTail.FNext := Nil;
                FTail.FValue := Value;
            End
            // если мы не в конце, то добавляем, в середину списка
            Else
            Begin
                New(NewNode);
                NewNode.FNext := CurNode.FNext;
                NewNode.FValue := Value;
                CurNode.FNext := NewNode;
            End;
        End;
    End;
    Inc(FCount);
End;

Procedure TList<T>.Clear;
Var
    TempNode: PtrNode;
Begin
    While FHead <> Nil Do
    Begin
        TempNode := FHead;
        FHead := FHead.FNext;
        Dispose(TempNode);
    End;
    FTail := FHead;
    FCount := 0;
End;

Constructor TList<T>.Create;
Begin
    FHead := Nil;
    FTail := FHead;
    FCount := 0;
    FComparer := Nil;
    FEqualityComparer := DefaultEqualityComparer;
End;

Class Function TList<T>.DefaultEqualityComparer(Var Item1, Item2: T): Boolean;
Begin
    DefaultEqualityComparer := Item1 = Item2;
End;

Procedure TList<T>.Delete(Value: T);
Var
    Cur, Temp: PtrNode;
Begin
    Cur := FHead;
    If FEqualityComparer(Cur.FValue, Value) Then
    Begin
        Temp := FHead;
        FHead := FHead.FNext;
        // если 1 элемент в списке
        If Temp = FTail Then
            FTail := FHead;
    End
    Else
    Begin
        While (Cur.FNext <> Nil) And
            Not(FEqualityComparer(Cur.FNext.FValue, Value)) Do
            Cur := Cur.FNext;
        If Cur.FNext <> Nil Then
        Begin
            Temp := Cur.FNext;
            Cur.FNext := Cur.FNext.FNext;
            // если удалили последний элемент
            If Cur.FNext = Nil Then
                FTail := Cur;
        End;
    End;
    Dispose(Temp);
    Dec(FCount);
End;

Function TList<T>.FindAllByValue(Value: T): TArray<T>;
Var
    ArrayOfItems: TArray<T>;
    ValuesCount: UInt32;
    Cur: PtrNode;
Begin
    ValuesCount := 0;
    Cur := FHead;
    // going through all list and compare with value
    While (Cur <> Nil) Do
    Begin
        If FEqualityComparer(Cur.FValue, Value) Then
        Begin
            Inc(ValuesCount);
            SetLength(ArrayOfItems, ValuesCount);
            ArrayOfItems[ValuesCount - 1] := Cur.FValue;
        End;
        Cur := Cur.FNext;
    End;
    FindAllByValue := ArrayOfItems;
End;

Function TList<T>.FindByValue(Value: T): Integer;
Var
    Cur: PtrNode;
    Index: Integer;
Begin
    Cur := FHead;
    Index := 0;
    // проходим по всем элементам, пока не встретим нужный
    While (Cur <> Nil) And Not FEqualityComparer(Cur.FValue, Value) Do
    Begin
        Cur := Cur.FNext;
        Inc(Index);  // увеличиваем индекс
    End;
    If (Cur = Nil) Or Not FEqualityComparer(Cur.FValue, Value) Then
        Index := -1;
    FindByValue := Index;
End;

Function TList<T>.GetItem(Index: Integer): T;
Var
    Cur: PtrNode;
    I: Integer;
Begin
    Cur := FHead;
    For I := 1 To Index Do
        Cur := Cur.FNext;
    GetItem := Cur.FValue;
End;

Function TList<T>.ToArray: TArray<T>;
Var
    ArrayOfItems: TArray<T>;
    Cur: PtrNode;
    I: Integer;
Begin
    SetLength(ArrayOfItems, FCount);
    Cur := FHead;
    I := 0;
    While Cur <> Nil Do
    Begin
        ArrayOfItems[I] := Cur.FValue;
        Cur := Cur.FNext;
        Inc(I);
    End;
    ToArray := ArrayOfItems;
End;

Function TList<T>.TryAdd(Value: T): Boolean;
Var
    IsAdded: Boolean;
Begin
    IsAdded := False;
    // ищим в списке, если не нашли, то готовимся к добавлению
    If FindByValue(Value) = -1 Then
        IsAdded := True;
    // если надо добавить, то добавляем
    If IsAdded Then
    Begin
        Add(Value);
    End;
    TryAdd := IsAdded;
End;

End.
