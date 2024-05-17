using Lab7_2;

Edge[] edges = null;
MainMenu mainMenu = new MainMenu();
ConsoleReader consoleReader = new ConsoleReader();
int choose = 0;
int countOfNodes = 0;
int countOfEdges = 0;
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
            
            countOfNodes  = consoleReader.InputCountOfNodes();
            countOfEdges = consoleReader.InputCountOfEdges();
            edges = consoleReader.InputElements(countOfEdges);
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
                    countOfNodes= fileReader.InputCountOfNodes();
                }
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    countOfEdges = fileReader.InputCountOfEdges();
                }
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    edges = fileReader.InputEdges(countOfEdges);
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
do
{
    // output block
    do
    {
        int[] path = Solver.FindPath(countOfNodes, edges!, consoleReader.InputStartV(), consoleReader.InputFinishV());
        mainMenu.OutputShowMenu();
        choose = mainMenu.InputChoice();
        // initialing reader
        switch ((WorkingTypes)choose)
        {
            case WorkingTypes.WtConsole:
            {
                ConsoleWriter consoleWriter = new ConsoleWriter();
                consoleWriter.Output(path);
            }
                break;
            case WorkingTypes.WtFile:
            {
                FileWriter fileWriter = new FileWriter();
                do
                {
                    fileWriter.FilePath = mainMenu.InputFilePath();
                    if (fileWriter.FileStatus == FileStatus.FsGood)
                        fileWriter.Output(path);
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

    mainMenu.OutputNewRequestInfo();
    choose = mainMenu.IntputNewRequest();
} while (choose == 1);

