unit InstructionUnit5_1;

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
        '1. Введите количество элементов двух списков (целое число > 0)' + #13#10 +
        '2. Нажмите кнопку ''подтвердить'', чтобы подтвердить размер списков.' + #13#10 +
        '3. Введите элементы первого списка (целые числа от -10^5 до 10^5).' + #13#10 +
        '3. Введите элементы второго списка (целые числа от -10^5 до 10^5).' + #13#10 +
        '4. Нажмите кнопку ''Слияние списков'', чтобы слить списки воедино.' + #13#10 +
        '5. Нажмите кнопку ''Посмотреть полученный список'',' + #13#10 +
        '     чтобы увидеть полученный список.' + #13#10 +
        'Примечания: ' + #13#10 +
        'Списки должны быть записаны не убывающем порядке.' + #13#10 +
        'Если используете файл, то он должен быть в формате ''.txt''.';
end;

end.
