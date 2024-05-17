unit AboutTheDeveloperUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TuVCLAboutTheDeveloper = class(TForm)
    Info: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  uVCLAboutTheDeveloper: TuVCLAboutTheDeveloper;

implementation

{$R *.dfm}

end.
