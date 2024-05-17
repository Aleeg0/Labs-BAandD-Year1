

using Lab5_2;

Tree<int> tree = new Tree<int>();
MainMenu mainMenu = new MainMenu();
int choose = 0;

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
            tree = consoleReader.InputElementsOfTree(consoleReader.InputSizeOfTree());
        }
            break;
        case WorkingTypes.WtFile:
        {
            FileReader fileReader = new FileReader();
            int size = 0;
            do
            {
                fileReader.FilePath = mainMenu.InputFilePath();
                // reading size and elements and checking status every operation
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    size = fileReader.InputSizeOfTree();
                }
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    tree = fileReader.InputElementsOfTree(size);
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
List<int> listOfValues = tree.FindValues();

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
            consoleWriter.Output(listOfValues);
        }
            break;
        case WorkingTypes.WtFile:
        {
            FileWriter fileWriter = new FileWriter();
            do
            {
                fileWriter.FilePath = mainMenu.InputFilePath();
                if (fileWriter.FileStatus == FileStatus.FsGood)
                    fileWriter.Output(listOfValues);
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