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
        'Äàííûå î ğàáîòíèêå ââîäÿòñÿ â òàáëèöó.' + #13#10 +
        'Äëÿ äîáàâëåíèÿ ğàáîòíèêà íàæìèòå êíîïêó ''äîáàâèòü ğàáîòíèêà''.' + #13#10 +
        'Äëÿ óäàëåíèÿ ğàáîòíèêà:' + #13#10 +
        '1. Íàæìèòå êíîïêó ''óäàëèòü ğàáîòíèêà'';' + #13#10 +
        '2. Ïîñëå ÷åãî âûñêî÷èò äîïîëíèòåëüíîå îêíî, â í¸ì ââåäèòå ïîğÿäêîâûé ' + #13#10 +
        '   íîìåğ ğàáîòíèêà, êîòîğîãî õîòèòå óäàëèòü; ' + #13#10 +
        '3. Ïîäâåğäèòå ñâîé âûáîğ, íàæàòèåì íà êíîïêó ''óäàëèòü''.' + #13#10 +
        'Äëÿ ïîëó÷åíèÿ äîïîëíèòåëüíîé èíôîğìàöèè, ââåäèòå ğàñöåíêè ' + #13#10 +
        'ïğåäìåòîâ A,B,C â ñîîòâåòñâóşùèå ïîëÿ.' + #13#10 +
        '×òîáû çàãğóçèòü äàííûå î ğàáî÷èõ â ôàéë:' + #13#10 +
        '1. Íàæìèòå ''äàííûå''. ' + #13#10 +
        '2. Íàæìèòå ''âûãğóçèòü äàííûå''.' + #13#10 +
        '×òîáû ñîõğàíèòü äàííûå î ğàáî÷èõ â ôàéë:' + #13#10 +
        '1. Íàæìèòå ''äàííûå''. ' + #13#10 +
        '2. Íàæìèòå ''ñîõğàíèòü äàííûå''.' + #13#10 +
        'Ïğèìå÷àíèÿ:' + #13#10 +
        'A) Ïğè âûãğóçêå è ñîõğàíåíèå ïğîãğàììà ğàáîòàåò ñî ñïåöèàëüíûìè ôàéëàìè' + #13#10 +
        'òèï ğàáî÷èõ!' + #13#10 +
        'Á) Ñîõğàíèòü ìîæíî òîãäà, êîãäà âñå äàííûå î ğàáî÷èõ ââåäåíû.' + #13#10 +
        'Â) Êîëè÷åñòâî äåòàëåé, ğàñöåíêè - öåëûå ÷èñëà > 0.' + #13#10;
End;

End.
