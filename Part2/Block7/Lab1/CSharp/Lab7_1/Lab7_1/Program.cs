using Lab7_1;

LinkedList<LinkedList<int>> nodes = new LinkedList<LinkedList<int>>();
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
            size = consoleReader.InputSizeOfNodes();
            nodes = consoleReader.InputElements(size);
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
                    size = fileReader.InputSizeOfNodes();
                }
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    nodes = fileReader.InputElements(size);
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
int[,] matrix = Solver.BuildMatrix(nodes,size);

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