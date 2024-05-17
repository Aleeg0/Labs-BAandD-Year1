unit InstructionUnit1_1;

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
    Info.Caption := '1. ������� ������ ����� N (0 < N < 10^9).' + #13#10 +
                    '2. ������� ������ ����� M (0 < M < 10^9).' + #13#10 +
                    '3. ������� �� ������ ���������, ����� �������� �����.' + #13#10 +
                    '����������: ���� ����������� ����, �� �� ������ ���� � ������� '+
                    #39 + '.txt' + #39  + #46 + #13#10;
end;


end.
