using System.Drawing;

namespace ConsoleApp1;

public class FileReader
{
    // constructors 
    public FileReader()
    {
        filePath = null;
    }

    public FileReader(String? filePath)
    {
        this.filePath = filePath;
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

    public int InputSizeOfArr()
    {
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
                    else if (size < 1)
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

    public int[] InputElementsOfArr(int size)
    {
        String? line = null;
        String[] strElements = null;
        char splitter = ' ';
        int[] arr = new int[size];
        try
        {
            using (StreamReader reader = new StreamReader(filePath))
            {
                try
                {
                    reader.ReadLine(); // skip reading size
                    line = reader.ReadLine();
                    strElements = line.Split(splitter);
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
        if (size != strElements.Length)
        {
            fileStatus = FileStatus.FsWrongCount;
        }
        for (int i = 0; i < size; i++)
        {
            if ((fileStatus == FileStatus.FsGood) && !int.TryParse(strElements[i], out arr[i]))
                fileStatus = FileStatus.FsWrongDataType;
        }
        return arr;

    }
}