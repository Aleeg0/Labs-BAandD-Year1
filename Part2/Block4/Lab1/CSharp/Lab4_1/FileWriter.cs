namespace Lab4_1;

public class FileWriter
{
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
        // TODO: добавь fileWritable?
        else if (fileStatus != FileStatus.FsUnexpacted)
        {
            fileStatus = FileStatus.FsGood;
        }
        return fileStatus;
    }
    
    
    public void WriteWorkers(Workers workers)
    {
        Worker worker;
        using StreamWriter writer = new StreamWriter(filePath,false);
        for (int i = 0; i < workers.Count; i++)
        {
            worker = workers[i];
            try
            {
                writer.WriteLine(worker.WSurname + " " +
                                 worker.WCompany + " " +
                                 worker.WCountOfDetailsA + " " +
                                 worker.WCountOfDetailsB + " " +
                                 worker.WCountOfDetailsC + " ");
            }
            catch (IOException e)
            {
                fileStatus = FileStatus.FsUnexpacted;
            }
        }
    }

    public void WriteDopInfo(int[] price, String? company, Workers workers)
    {
        Worker worker;
        double allWorkersSalaryOfCompany = 0;
        int salaryOfWorker = 0;
        int counterOfWorkersOfCompany = 0;
        try
        {
            using StreamWriter writer = new StreamWriter(filePath, false);
            {
                try
                {
                    writer.WriteLine("Информация о цехе: " + company);
                }
                catch (IOException e)
                {
                    fileStatus = FileStatus.FsUnexpacted;
                }
                for (int i = 0; i < workers.Count; i++)
                {
                    worker = workers[i];
                    // finding a worker which works in this company
                    if (worker.WCompany.Equals(company))
                    {
                        counterOfWorkersOfCompany++;
                        salaryOfWorker = worker.WCountOfDetailsA * price[0] +
                                         worker.WCountOfDetailsB * price[1] +
                                         worker.WCountOfDetailsC * price[2];
                        allWorkersSalaryOfCompany += (double)salaryOfWorker;
                        try
                        {
                            // writing summary count of details has done by worker
                            writer.WriteLine("Количество деталей сделанных рабочим " + worker.WSurname + ": " +
                                             (worker.WCountOfDetailsA + worker.WCountOfDetailsB +
                                              worker.WCountOfDetailsC));
                            // writing worker's salary

                            writer.WriteLine("ЗП работника " + worker.WSurname + ": " + salaryOfWorker);
                        }
                        catch (IOException e)
                        {
                            fileStatus = FileStatus.FsUnexpacted;
                        }
                    }
                }
                try
                {
                    // writing Avg salary of company
                    writer.WriteLine("Средня ЗП цеха " + company + ": " +
                                     (allWorkersSalaryOfCompany / (double)counterOfWorkersOfCompany));
                }
                catch (IOException e)
                {
                    fileStatus = FileStatus.FsNotWritable;
                }
            }
        }
        catch (IOException e)
        {
            fileStatus = FileStatus.FsUnexpacted;
        }
    }
}