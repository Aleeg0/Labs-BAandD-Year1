using Lab6_2;

MainMenu mainMenu = new MainMenu();
int choose = 0;
int size = 0;
mainMenu.ShowProgramInfo();

// input block
do
{
    mainMenu.InputShowMenu();
    choose = mainMenu.InputChoice();
    // initialing reader
    switch ((WorkingTypes)choose)
    {
        case WorkingTypes.WtConsole:
        {
            ConsoleReader consoleReader = new ConsoleReader();
            size = consoleReader.InputSizeOfSquare();
        }
            break;
        case WorkingTypes.WtFile:
        {
            FileReader fileReader = new FileReader();
            do
            {
                fileReader.FilePath = mainMenu.InputFilePath();
                // reading size and elements and checking status every operation
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    size = fileReader.InputSizeOfSquare();
                }
            } while (fileReader.FileStatus != FileStatus.FsGood);
        }
            break;
        default:
        {
            mainMenu.ShowWrongKeyMessage();
            choose = 0;
        }
            break;
    }
} while (choose < (int)WorkingTypes.WtConsole || (int)WorkingTypes.WtFile < choose);

// main block
MSquareBuilder mSquareBuilder = new MSquareBuilder(size);
mSquareBuilder.BuildHugeMatrix();
mSquareBuilder.MoveLeftPart();
mSquareBuilder.MoveTopPart();
mSquareBuilder.MoveRightPart();
mSquareBuilder.MoveBottomPart();
int[,] matrix = mSquareBuilder.Matrix;

// output block
do
{
    mainMenu.OutputShowMenu();
    choose = mainMenu.InputChoice();
    // initialing reader
    switch ((WorkingTypes)choose)
    {
        case WorkingTypes.WtConsole:
        {
            ConsoleWriter consoleWriter = new ConsoleWriter();
            consoleWriter.Output(matrix,size);
        }
            break;
        case WorkingTypes.WtFile:
        {
            FileWriter fileWriter = new FileWriter();
            do
            {
                fileWriter.FilePath = mainMenu.InputFilePath();
                if (fileWriter.FileStatus == FileStatus.FsGood)
                    fileWriter.Output(matrix,size);
                mainMenu.ShowFileStatusMessage(fileWriter.FileStatus);
            } while (fileWriter.FileStatus != FileStatus.FsGood);
        }
            break;
        default:
        {
            mainMenu.ShowWrongKeyMessage();
            choose = 0;
        }
            break;
    }
} while (choose < 0 || (int)WorkingTypes.WtFile < choose);