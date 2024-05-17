
using ConsoleApp1;

MainMenu mainMenu = new MainMenu();

int choose = 0;
int size = 0;
int[] arr = null;

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
            arr = consoleReader.InputElementsOfArr(consoleReader.InputSizeOfArr());
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
                    size = fileReader.InputSizeOfArr();
                }
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    arr = fileReader.InputElementsOfArr(size);
                }
                mainMenu.ShowFileStatusMessage(fileReader.FileStatus);
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
Sorter sorter = new Sorter();
sorter.QuickSort(ref arr,0,arr.Length - 1);

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
            consoleWriter.Output(arr);
        }
            break;
        case WorkingTypes.WtFile:
        {
            FileWriter fileWriter = new FileWriter();
            do
            {
                fileWriter.FilePath = mainMenu.InputFilePath();
                if (fileWriter.FileStatus == FileStatus.FsGood)
                    fileWriter.Output(arr);
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