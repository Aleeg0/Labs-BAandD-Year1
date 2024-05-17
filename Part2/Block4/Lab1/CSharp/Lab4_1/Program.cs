//program once

using Lab4_1;

int choose;

MainMenu mainMenu = new MainMenu();
Workers workers = new Workers();

mainMenu.ShowProgramInfo();
do
{
    mainMenu.ShowMainMenu();
    choose = mainMenu.InputChoose();
    switch ((MenuStatus)choose)
    {
        case MenuStatus.MsShowTable:
        {
            do
            {
                // show table
                mainMenu.ShowTable(workers);
                // new request
                mainMenu.ShowTableMenu();
                choose = mainMenu.InputChoose();
                switch ((TableMenuStatus)choose)
                {
                    case TableMenuStatus.TmsAddWorker:
                    {
                        workers.AddWorker(mainMenu.InputWorker());
                    }
                        break;
                    case TableMenuStatus.TmsDeleteWorker:
                    {
                        if (workers.Count > 0)
                            workers.DeleteWorker(mainMenu.InputId(workers.Count));
                        else
                            mainMenu.ShowErrorEmptyMessage();
                    }
                        break;
                    case TableMenuStatus.TmsChangeWorker:
                    {
                        if (workers.Count > 0)
                            workers.ChangeWorker(mainMenu.InputId(workers.Count),mainMenu.InputWorker());
                        else
                            mainMenu.ShowErrorEmptyMessage();
                    }
                        break;
                    case TableMenuStatus.TmsExitToMainMenu:
                    {
                        mainMenu.ShowTableMenuExitMessage(); 
                    }
                        break; 
                    default:
                    {
                        mainMenu.ShowErrorKeyMessage();
                        choose = 0; // to continue loop
                    }
                        break;
                }
                //Console.Clear();  
            } while ((-1 < choose) && (choose < (int)TableMenuStatus.TmsExitToMainMenu));
        }
            break;
        case MenuStatus.MsDownloadTable:
        {
            FileReader fileReader = new FileReader();
            do
            {
                fileReader.FilePath = mainMenu.InputFilePath();
                // reading file to get workers
                if (fileReader.FileStatus == FileStatus.FsGood)
                {
                    // output info about starting reading
                    mainMenu.LoadDataMessage();
                    // launch this process
                    workers = fileReader.ReadTable();
                }
                // showing fileStatus message for user 
                mainMenu.ShowFileStatusMessage(fileReader.FileStatus);
            } while (fileReader.FileStatus != FileStatus.FsGood);
        }
            break;
        case MenuStatus.MsSaveTable:
        {
            FileWriter fileWriter = new FileWriter();
            do
            {
                fileWriter.FilePath = mainMenu.InputFilePath();
                // writing workers to file
                if (fileWriter.FileStatus == FileStatus.FsGood)
                    fileWriter.WriteWorkers(workers);
                // showing fileStatus message for user
                mainMenu.ShowFileStatusMessage(fileWriter.FileStatus);
            } while (fileWriter.FileStatus != FileStatus.FsGood);
        }
            break;
        case MenuStatus.MsSaveDopInfo:
        {
            FileWriter fileWriter = new FileWriter();
            do
            {
                fileWriter.FilePath = mainMenu.InputFilePath();
                // writing dop info into file
                if (fileWriter.FileStatus == FileStatus.FsGood)
                    fileWriter.WriteDopInfo(mainMenu.InputPrices(),mainMenu.InputCompany(workers),workers);
                // showing fileStatus message for user
                mainMenu.ShowFileStatusMessage(fileWriter.FileStatus);
            } while (fileWriter.FileStatus != FileStatus.FsGood);
        }
            break;
        case MenuStatus.MsExit:
        {
            mainMenu.ShowProgramExitMessage();
        }
            break;
        default:
        {
            mainMenu.ShowErrorKeyMessage();
            choose = 0; // to continue loop
        }
            break;
    }
    //Console.Clear();  
} while ((-1 < choose) && (choose < (int)MenuStatus.MsExit));