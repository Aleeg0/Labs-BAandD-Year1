Unit InstructionUnit2_1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TInstructionForm = Class(TForm)
        Info: TLabel;
        Procedure FormCreate(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    InstructionForm: TInstructionForm;

Implementation

{$R *.dfm}

Procedure TInstructionForm.FormCreate(Sender: TObject);
Begin
    Info.Caption :=
        '1. ������� ���������� ������������� (0 < ���. ������������� < 100).' + #13#10 +
        '2. ������� ������ ''�����������'' ����� ����, ��� ������ ���. �������������.' + #13#10 +
        '3. ������� ������ ������� ������������ ( 0 < ������� ������������ < 10^5)' +#13#10 +
        '    � ��������������� ������.' + #13#10 +
        '4. ������� ������ ''����� �����������'', ����� ��������� �����'+ #13#10 +
        '    ����������� ������������ ��������.' + #13#10 +
        '����������: ���� ����������� ����, �� �� ������ ���� � ������� ''.txt''.';
End;

End.
