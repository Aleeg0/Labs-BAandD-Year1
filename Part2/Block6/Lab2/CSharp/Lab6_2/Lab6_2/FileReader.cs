using System.Drawing;

namespace Lab6_2;

public class FileReader
{
    // constructors 
    public FileReader()
    {
        filePath = null;
    }

    // filePath field
    private string? filePath;

    public string? FilePath
    {
        get => filePath;
        set 
        { 
            filePath = value;
            fileStatus = FileStatus.FsGood;
        }

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

    public int InputSizeOfSquare()
    {
        const int MAX_SIZE = 9;
        const int MIN_SIZE = 3;
        int size = 0;
        String? line = null;
        try
        {
            using (StreamReader reader = new StreamReader(filePath))
            {
                try
                {
                    line = reader.ReadLine();
                    if (line == null)
                        fileStatus = FileStatus.FsEmpty;
                    else if (!int.TryParse(line, out size))
                        fileStatus = FileStatus.FsWrongDataType;
                    else if (size < MIN_SIZE || MAX_SIZE < size)
                        fileStatus = FileStatus.FsWrongDataType;
                    else if (size % 2 == 0)
                        fileStatus = FileStatus.FsWrongDataType;
                }
                catch (IOException e)
                {
                    fileStatus = FileStatus.FsUnexpacted;
                }
            }
        }
        catch (UnauthorizedAccessException e)
        {
            fileStatus = FileStatus.FsNotReadable;
        }

        return size;
    }

    public void MakeWrongData()
    {
        fileStatus = FileStatus.FsWrongDataType;
    }
}