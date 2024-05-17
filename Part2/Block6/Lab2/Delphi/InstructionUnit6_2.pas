unit InstructionUnit6_2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TuVCLInstruction = class(TForm)
    Info: TLabel;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  uVCLInstruction: TuVCLInstruction;

implementation

{$R *.dfm}



procedure TuVCLInstruction.FormCreate(Sender: TObject);
begin
    Info.Caption :=
        '1. Введите размер квадрата нечетное число от 3 до 9' + #13#10 +
        '2. Нажмите кнопку ''подтвердить'', чтобы подтвердить размер списков.' + #13#10 +
        '3. Для того, чтобы увидеть следующий шаг нажмите ''Следующий шаг'' .' + #13#10 +
        'Примечания: ' + #13#10 +
        'В файле только указывать размер!' + #13#10 +
        'Если используете файл, то он должен быть в формате ''.txt''.';
end;

end.
