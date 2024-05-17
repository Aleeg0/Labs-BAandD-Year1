Unit BackendUnit5_2;

Interface

Uses System.SysUtils, System.Generics.Collections;

Type
    PtrRoot = ^TRoot;

    TRoot = Record
        FValue: Integer;
        FRight: PtrRoot;
        FLeft: PtrRoot;
        FPrev: PtrRoot;
        Procedure Init(Value: Integer);
    End;

    TTree = Class
    Private
        FPtrHeader: PtrRoot;
        Function FindValues(Var Tree: PtrRoot; Var List: TList<Integer>)
            : Integer; Overload;
    Public
        Procedure Add(Value: Integer);
        Function GetRight(Root : PtrRoot): PtrRoot;
        Function GetLeft(Root : PtrRoot) : PtrRoot;
        Property Head : PtrRoot read FPtrHeader;
        Function FindValues(): TList<Integer>; Overload;
    End;

    TTypes = (TpInteger, TpUInteger, TpReal, TpString);

    TBufferHandler = Class
    Private
        FEditText: String;
        Function CountSymbol(Const Symbol: Char): Integer;
    Public
        Function CheckInput(Const InputType: TTypes): Boolean;
        Function CheckRange(Const MIN, MAX; Const InputType: TTypes): Boolean;
        Procedure DeleteLeadingZeros(Const InputType: TTypes);
        Property EditText: String Read FEditText Write FEditText;
    End;

    TFileStatus = (FsGood, FsNotFound, FsNotTxt, FsNotReadable, FsNotWritable,
        FsEmpty, FsWrongData, FsUnexpected);

    TFileReader = Class
    Private
        FFileName: String;
        FInFile: TextFile;
        FFileStatus: TFileStatus;
        Function IsFileTxt(): Boolean;
        Function IsFileReadable(): Boolean;
        Function IsEmpty(): Boolean;
        Procedure SetFileName(Const FFileName: String);
    Public
        Property Status: TFileStatus Read FFileStatus;
        Property FileName: String Read FFileName Write SetFileName;
        Procedure CheckFile();
        Function ReadSize(): Integer;
        Function ReadList(Const Size: Integer): TList<Integer>;
    End;

    TFileWriter = Class
    Private
        FFileName: String;
        FOutFile: TextFile;
        FFileStatus: TFileStatus;
        Function IsFileTxt(): Boolean;
        Function IsFileWritable(): Boolean;
        Procedure SetFileName(Const FFileName: String);
    Public
        Constructor Create();
        Property Status: TFileStatus Read FFileStatus;
        Property FileName: String Read FFileName Write SetFileName;
        Procedure CheckFile();
        Procedure WriteList(Var List: TList<Integer>);
    End;

    TListOfMessages = Array [TFileStatus] Of PWideChar;

Const
    ListOfMessages: TListOfMessages = ('���������� ��������!',
        '���� �� ������! ��������� ��� ���.',
        '���� �� ���������! ��������� ��� ���.',
        '���� �� �������� ��� ������! ��������� ��� ���.',
        '���� �� �������� ��� ������! ��������� ��� ���.',
        '���� ������! ��������� ��� ���.',
        '�� ������ ������ � �����! ��������� ��� ���.',
        '���... ���-�� ����� �� ���. ��������� ��� ���.');

Var
    Tree: TTree;

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
                Else If (CountOfMinuses = 1) Then
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
        TpReal:
            Begin
                CountOfMinuses := CountSymbol('-');
                CountOfCommas := CountSymbol(',');
                If (CountOfMinuses = 0) And (CountOfCommas = 0) Then
                Begin
                    For I := Low(FEditText) To High(FEditText) Do
                        If Status And Not(FEditText[I] In GOOD_KEYS) Then
                            Status := False;
                End
                Else If (CountOfMinuses = 1) And (CountOfCommas = 0) Then
                Begin
                    For I := 2 To High(FEditText) Do
                        If Status And Not(FEditText[I] In GOOD_KEYS) Then
                            Status := False;
                End
                Else If (CountOfMinuses = 0) And (CountOfCommas = 1) Then
                Begin
                    For I := 1 To High(FEditText) Do
                        If Status And
                            Not((FEditText[I] In GOOD_KEYS) Or
                            (FEditText[I] = ',')) Then
                            Status := False;
                End
                Else If (CountOfMinuses = 1) And (CountOfCommas = 1) Then
                Begin
                    For I := 2 To High(FEditText) Do
                        If Status And
                            Not((FEditText[I] In GOOD_KEYS) Or
                            (FEditText[I] = ',')) Then
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
        TpReal:
            Begin
                // ��� ������, �� �����, ���� ��������� :)
                Var
                    Number: Real;
                Number := StrToFloat(FEditText);
                If (Number < Real(MIN)) Or (Real(MAX) < Number) Then
                    IsGood := False;
            End;
        TpString:
            // ���� �� ��� ��� ������
            ;
    Else
        ;
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
        TpReal:
            // TODO
            ;
        TpString:
            // Why?
            ;
    End;

End;

{ TFileReader }

Procedure TFileReader.CheckFile();
Begin
    If Not FileExists(FileName) Then
        FFileStatus := FsNotFound
    Else If Not IsFileTxt() Then
        FFileStatus := FsNotTxt
    Else If Not IsFileReadable() Then
        FFileStatus := FsNotReadable
    Else If IsEmpty() Then
        FFileStatus := FsEmpty
    Else
        FFileStatus := FsGood;
End;

Function TFileReader.IsEmpty: Boolean;
Var
    Status: Boolean;
Begin
    Try
        Reset(FInFile);
        Status := Eof(FInFile);
        CloseFile(FInFile);
    Except
    End;
    IsEmpty := Status;
End;

Function TFileReader.IsFileReadable(): Boolean;

Var
    Status: Boolean;
Begin
    Status := True;
    Try
        Reset(FInFile);
        CloseFile(FInFile);
    Except
        Status := False;
    End;
    IsFileReadable := Status;
End;

Function TFileReader.IsFileTxt(): Boolean;

Var
    FileType: String;
    Status: Boolean;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Status := True
    Else
        Status := False;
    IsFileTxt := Status;
End;

Function TFileReader.ReadList(Const Size: Integer): TList<Integer>;
Var
    List: TList<Integer>;
    I: Integer;
    Num: Integer;
Begin
    List := TList<Integer>.Create();
    Try
        ReSet(FInFile);
        Readln(FInFile);
        For I := 1 To SIZE Do
        Begin
            If Eof(FInFile) Then
                FFileStatus := FsWrongData
            Else
            Begin
                Read(FInFile, Num);
                List.Add(Num);
            End;
        End;
        CloseFile(FInFile);
    Except
        FFileStatus := FsUnexpected;
    End;
    ReadList := List;
End;

Function TFileReader.ReadSize(): Integer;
Var
    Size: Integer;
Begin
    Size := 0;
    Try
        ReSet(FInFile);
        Readln(FInFile, Size);
        CloseFile(FInFile);
    Except
        FFileStatus := FsUnexpected;
    End;
    If Size < 1 Then
        FFileStatus := FsWrongData;
    ReadSize := Size;
End;

Procedure TFileReader.SetFileName(Const FFileName: String);
Begin
    Self.FFileName := FFileName;
    Assign(FInFile, Self.FFileName);
End;

{ TFileWriter }

Procedure TFileWriter.CheckFile;
Begin
    If Not FileExists(FileName) Then
        FFileStatus := FsNotFound
    Else If Not IsFileWritable() Then
        FFileStatus := FsNotWritable
    Else
        FFileStatus := FsGood;
End;

Function TFileWriter.IsFileWritable(): Boolean;

Var
    Status: Boolean;
Begin
    Status := True;
    Try
        Rewrite(FOutFile);
        CloseFile(FOutFile);
    Except
        Status := False;
    End;
    IsFileWritable := Status;
End;

Procedure TFileWriter.SetFileName(Const FFileName: String);
Begin
    Self.FFileName := FFileName;
    Assign(FOutFile, Self.FFileName);
End;

Procedure TFileWriter.WriteList(Var List: TList<Integer>);
Var
    I: Integer;
Begin
    Try
        ReWrite(FOutFile);
        Writeln(FOutFile, '������ ������� ����:');
        For I := 1 To List.Count Do
            Write(FOutFile, List[I - 1], ' ');
        Writeln(FOutFile);
        CloseFile(FOutFile);
    Except
        FFileStatus := FsUnexpected;
    End;
End;

Constructor TFileWriter.Create();
Begin

End;

Function TFileWriter.IsFileTxt: Boolean;

Var
    FileType: String;
    Status: Boolean;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Status := True
    Else
        Status := False;
    IsFileTxt := Status;
End;

{ TTree.TRoot }

Procedure TRoot.Init(Value: Integer);
Var
    PtrTemp: PtrRoot;
Begin
    Self.FValue := Value;
    Self.FRight := Nil;
    Self.FLeft := Nil;
    Self.FPrev := Nil;
End;

{ TTree }

Procedure TTree.Add(Value: Integer);
Var
    CurRoot: PtrRoot;
    IsWriten: Boolean;
Begin
    If FPtrHeader = Nil Then
    Begin
        New(FPtrHeader);
        FPtrHeader.Init(Value);
    End
    Else
    Begin
        CurRoot := FPtrHeader;
        IsWriten := False;
        While Not IsWriten Do
        Begin
            If CurRoot.FValue > Value Then
            Begin
                If CurRoot.FLeft = Nil Then
                Begin
                    New(CurRoot.FLeft);
                    CurRoot.FLeft.Init(Value);
                    CurRoot.FLeft.FPrev := CurRoot;
                    IsWriten := True;
                End
                Else
                    CurRoot := CurRoot.FLeft;
            End
            Else If CurRoot.FValue < Value Then
            Begin
                If CurRoot.FRight = Nil Then
                Begin
                    New(CurRoot.FRight);
                    CurRoot.FRight.Init(Value);
                    CurRoot.FRight.FPrev := CurRoot;
                    IsWriten := True;
                End
                Else
                    CurRoot := CurRoot.FRight;
            End
            Else
                IsWriten := True;
        End;
    End;
End;

Function TTree.FindValues: TList<Integer>;
Var
    List: TList<Integer>;
Begin
    List := TList<Integer>.Create();
    FindValues(FPtrHeader, List);
    FindValues := List;
End;

function TTree.GetLeft(Root : PtrRoot): PtrRoot;
begin
    GetLeft := Root.FLeft;
end;

Function TTree.GetRight(Root : PtrRoot): PtrRoot;
Begin
    GetRight := Root.FRight;
End;

Function TTree.FindValues(Var Tree: PtrRoot; Var List: TList<Integer>): Integer;
Var
    Left: Integer;
    Right: Integer;
Begin
    If Tree = Nil Then
        Exit(0);
    Left := FindValues(Tree.FLeft, List) + 1;
    Right := FindValues(Tree.FRight, List) + 1;
    If Left <> Right Then
        List.Add(Tree.FValue);
    If Left > Right Then
        FindValues := Left
    Else
        FindValues := Right;
End;

End.
