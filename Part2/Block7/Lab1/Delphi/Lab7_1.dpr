program Lab7_1;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {uVCLMain},
  Vcl.Themes,
  Vcl.Styles,
  AddNodeUnit in 'AddNodeUnit.pas' {uVCLAddNode},
  LinkedList in 'LinkedList.pas',
  BufferHandler in 'BufferHandler.pas',
  DeleteUnit in 'DeleteUnit.pas' {uVCLDelete},
  MatrixUnit in 'MatrixUnit.pas' {uVCLMatrix},
  AboutTheDeveloperUnit7_1 in 'AboutTheDeveloperUnit7_1.pas' {uVCLAboutTheDeveloper},
  InstructionUnit7_1 in 'InstructionUnit7_1.pas' {uVCLInstruction};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glossy');
  Application.CreateForm(TuVCLMain, uVCLMain);
  Application.CreateForm(TuVCLDelete, uVCLDelete);
  Application.CreateForm(TuVCLMatrix, uVCLMatrix);
  Application.CreateForm(TuVCLAboutTheDeveloper, uVCLAboutTheDeveloper);
  Application.CreateForm(TuVCLInstruction, uVCLInstruction);
  Application.Run;
end.
