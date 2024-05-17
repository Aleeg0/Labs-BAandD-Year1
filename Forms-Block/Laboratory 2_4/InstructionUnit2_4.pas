unit InstructionUnit2_4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TInstructionForm = class(TForm)
    Info: TLabel;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InstructionForm: TInstructionForm;

implementation

{$R *.dfm}



procedure TInstructionForm.FormCreate(Sender: TObject);
begin
    Info.Caption :=
        '1. ������� ������ ���������� ������� (�� 3 �� 100).' + #13#10 +
        '2. ������� ������ ''�����������'' ����� ����, ��� ������ ������ �������.' + #13#10 +
        '3. ������� ������ ������� ������� ( -10^5 < ������� ������� < 10^5)' +#13#10 +
        '    � ��������������� ������.' + #13#10 +
        '4. ������� ������ ''����� �����'', ����� ��������� �����'+ #13#10 +
        '    ����� � ����������� �����.' + #13#10 +
        '����������: ���� ����������� ����, �� �� ������ ���� � ������� ''.txt''.';
end;

end.
