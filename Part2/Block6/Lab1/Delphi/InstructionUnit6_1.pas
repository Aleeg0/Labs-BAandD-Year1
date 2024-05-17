unit InstructionUnit6_1;

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
    Info.Caption := 'Инструкция:' + #13#10 +
        'Программа позваляет управлять корабликом:' + #13#10 +
        'A(<-) - движение влево;' + #13#10 + 'D(->) - движение вправо;' + #13#10
        + 'Для увеличения скорости нажмите S;' + #13#10 +
        'Для уменьшения скорости нажмите B;' + #13#10;
end;

end.
