Unit UnitAboutTheDeveloper;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TuVCLAboutTheDeveloper = Class(TForm)
        Info: TLabel;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    Private
        FIsClose: Boolean;
    Public
        Property IsClose: Boolean Read FIsClose;
    End;

Var
    uVCLAboutTheDeveloper: TuVCLAboutTheDeveloper;

Implementation

{$R *.dfm}

Procedure TuVCLAboutTheDeveloper.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    FIsClose := True;
End;

procedure TuVCLAboutTheDeveloper.FormCreate(Sender: TObject);
begin
    FIsClose := False;
end;

End.
