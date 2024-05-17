using Microsoft.VisualBasic;

namespace Lab4_1;

public class FileReader
{
        public FileReader()
        {
            filePath = null;
        }
        
        
        private string? filePath;

        public string? FilePath
        {
            get => filePath;
            set => filePath = value;
        }

        private FileStatus fileStatus;

        public FileStatus FileStatus
        {
            get => CheckFileStatus();
            private set => fileStatus = value;
        }

        private FileStatus CheckFileStatus()
        {
            FileInfo fileInfo = new FileInfo(filePath);
            if (!fileInfo.Exists)
            {
                fileStatus = FileStatus.FsNotFound;
            }
            else if (!filePath.EndsWith(".txt"))
            {
                fileStatus = FileStatus.FsNotTxt;
            }
            // else if (!fileInfo.IsReadOnly)
            // {
            //     fileStatus = FileStatus.FsNotReadable;
            // }
            else if (fileStatus != FileStatus.FsUnexpacted)
            {
                fileStatus = FileStatus.FsGood;
            }
            return fileStatus;
        }
    
    public Workers ReadTable()
    {
        Workers workers = new Workers();
        Worker worker = new Worker();
        String? line = null;
        int details = 0;
        const char splitter = ' ';
        try
        {
            using (StreamReader reader = new StreamReader(filePath))
            {
                try
                {
                    while ((line = reader.ReadLine()) != null)
                    {
                        // split for 5 string our line
                        String[] strWorker = line.Split(splitter);
                        // writing data to worker
                        worker.WSurname = strWorker[0];
                        worker.WCompany = strWorker[1];
                        if (int.TryParse(strWorker[2], out details))
                        {
                            worker.WCountOfDetailsA = details;
                        }
                        else
                        {
                            fileStatus = FileStatus.FsUnexpacted;
                        }
                        if (int.TryParse(strWorker[2], out details))
                        {
                            worker.WCountOfDetailsB = details;
                        }
                        else
                        {
                            fileStatus = FileStatus.FsUnexpacted;
                        }
                        if (int.TryParse(strWorker[2], out details))
                        {
                            worker.WCountOfDetailsC = details;
                        }
                        else
                        {
                            fileStatus = FileStatus.FsUnexpacted;
                        }
                        workers.AddWorker(worker);
                    }
                }
                catch (IOException e)
                {
                    fileStatus = FileStatus.FsUnexpacted;
                }
            }
        }
        catch (IOException e)
        {
            fileStatus = FileStatus.FsNotReadable;
        }
        return workers;
    }
}