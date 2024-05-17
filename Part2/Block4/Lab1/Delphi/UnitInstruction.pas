Unit UnitInstruction;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TuVCLInstruction = Class(TForm)
        Info: TLabel;
        Procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Private
        FIsClose: Boolean;
    Public
        Property IsClose: Boolean Read FIsClose;
    End;

Var
    uVCLInstruction: TuVCLInstruction;

Implementation

{$R *.dfm}

procedure TuVCLInstruction.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FIsClose := True;
end;

Procedure TuVCLInstruction.FormCreate(Sender: TObject);
Begin
    FIsClose := False;
    Info.Caption :=
        '������ � ��������� �������� � �������.' + #13#10 +
        '��� ���������� ��������� ������� ������ ''�������� ���������''.' + #13#10 +
        '��� �������� ���������:' + #13#10 +
        '1. ������� ������ ''������� ���������'';' + #13#10 +
        '2. ����� ���� �������� �������������� ����, � �� ������� ���������� ' + #13#10 +
        '   ����� ���������, �������� ������ �������; ' + #13#10 +
        '3. ���������� ���� �����, �������� �� ������ ''�������''.' + #13#10 +
        '��� ��������� �������������� ����������, ������� �������� ' + #13#10 +
        '��������� A,B,C � �������������� ����.' + #13#10 +
        '����� ��������� ������ � ������� � ����:' + #13#10 +
        '1. ������� ''������''. ' + #13#10 +
        '2. ������� ''��������� ������''.' + #13#10 +
        '����� ��������� ������ � ������� � ����:' + #13#10 +
        '1. ������� ''������''. ' + #13#10 +
        '2. ������� ''��������� ������''.' + #13#10 +
        '����������:' + #13#10 +
        'A) ��� �������� � ���������� ��������� �������� �� ������������ �������' + #13#10 +
        '��� �������!' + #13#10 +
        '�) ��������� ����� �����, ����� ��� ������ � ������� �������.' + #13#10 +
        '�) ���������� �������, �������� - ����� ����� > 0.' + #13#10;
End;

End.
