namespace Lab6_2;

public class FileWriter
{
    // constructors 
    public FileWriter()
    {
        filePath = null;
    }

    public FileWriter(String? filePath)
    {
        this.filePath = filePath;
    }

    // filePath field
    private string? filePath;

    public string? FilePath
    {
        get => filePath;
        set => filePath = value;
    }

    // fileStatus field
    private FileStatus fileStatus;

    public FileStatus FileStatus
    {
        get => CheckFileStatus();
        private set => fileStatus = value;
    }

    // methods of object
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
        return fileStatus;
    }

    public void Output(int[,] matrix, int size)
    {
        try
        {
            using StreamWriter writer = new StreamWriter(filePath);
            writer.WriteLine("Магический квадрат.");
            for (int i = 0; i < size; i++)
            {
                for (int j = 0; j < size; j++)
                    writer.Write(matrix.Length + " ");
                writer.WriteLine();
            }

            writer.WriteLine();
        }
        catch (UnauthorizedAccessException e)
        {
            fileStatus = FileStatus.FsNotWritable;
        }
    }
}