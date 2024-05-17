unit InstructionUnit1_3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TInstruction = class(TForm)
    Info: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Instruction: TInstruction;

implementation

{$R *.dfm}

procedure TInstruction.FormCreate(Sender: TObject);
begin
    Info.Caption := '1. ������� �������, ���� ������ ������ ���� eps > 0.' + #13#10 +
                    '1a. ���� ������ �������, ������� �������.' + #13#10 +
                    '2. ������� X (0 < X < 10^6).' + #13#10 +
                    '3. ������� ������ ' + #39 + '���������' + #39 + ', ����� ��������� ����� X.' + #13#10+
                    '4. ������� ������ ' + #39 + '���������� �����' + #39 + ', ����� ������� ��������� �������.' + #13#10+
                    '����������: ���� ����������� ����, �� �� ������ ���� � ������� ' +
                    #39 + '.txt' + #39 + #46 + #13#10 +
                    '��� �� ��� ����������� �������� � ������ ������ ������ ����' + #13#10 +
                    '  � ����� ������� "X eps".' + #13#10 +
                    '��������: 10 0.001' + #13#10 +
                    '�� ���� �� ����������� eps �� ���������, �� � ���� ������� ������ X.' + #13#10 +
                    '��������: 5' + #13#10;
end;

end.
