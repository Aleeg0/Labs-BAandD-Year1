using Lab5_1;

MainMenu mainMenu = new MainMenu();

int choose = 0;
int size = 0;
List<int> list1 = null; 
List<int> list2 = null;
List<int> mergedList = null;
Merger merger = new Merger();

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
            do
            {
                list1 = consoleReader.InputElementsOfList(consoleReader.InputSizeOfList());
            } while (merger.IsListDecreasing(list1));
            do
            {
                list2 = consoleReader.InputElementsOfList(consoleReader.InputSizeOfList());
            } while (merger.IsListDecreasing(list2));
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
                    size = fileReader.InputSizeOfList();
                }
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    list1 = fileReader.InputElementsOfList(size);
                }
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    size = fileReader.InputSizeOfList();
                }
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    list2 = fileReader.InputElementsOfList(size);
                }
                if (fileReader.FileStatus == FileStatus.FsGood &&
                    (merger.IsListDecreasing(list1) || merger.IsListDecreasing(list2)))
                {
                    mainMenu.ShowWrongSequenceMessage();
                    fileReader.MakeWrongData();
                }
                else
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
mergedList = merger.MergeTwoLists(list1, list2);

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
            consoleWriter.Output(mergedList);
        }
            break;
        case WorkingTypes.WtFile:
        {
            FileWriter fileWriter = new FileWriter();
            do
            {
                fileWriter.FilePath = mainMenu.InputFilePath();
                if (fileWriter.FileStatus == FileStatus.FsGood)
                    fileWriter.Output(mergedList);
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