program Lab7_2;

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
  AboutTheDeveloperUnit in 'AboutTheDeveloperUnit.pas' {uVCLAboutTheDeveloper},
  InstructionUnit in 'InstructionUnit.pas' {uVCLInstruction},
  EdgeUnit in 'EdgeUnit.pas',
  GraphUnit in 'GraphUnit.pas' {uVCLGraph},
  FindMinPathUnit in 'FindMinPathUnit.pas' {uVCLFindPath};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glossy');
  Application.CreateForm(TuVCLMain, uVCLMain);
  Application.CreateForm(TuVCLFindPath, uVCLFindPath);
  Application.Run;
end.
