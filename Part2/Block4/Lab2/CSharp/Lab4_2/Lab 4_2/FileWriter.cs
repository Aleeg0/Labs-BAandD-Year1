namespace ConsoleApp1;

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

    public void Output(int[] arr)
    {
        try
        {
            using StreamWriter writer = new StreamWriter(filePath);
            writer.WriteLine("Отсортированный массив:");
            for (int i = 0; i < arr.Length; i++)
            {
                writer.Write(arr[i] + " ");
            }

            writer.WriteLine();
        }
        catch (UnauthorizedAccessException e)
        {
            fileStatus = FileStatus.FsNotWritable;
        }
    }
}