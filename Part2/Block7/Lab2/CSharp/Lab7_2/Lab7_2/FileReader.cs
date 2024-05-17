using System.Drawing;

namespace Lab7_2;

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

    public int InputCountOfNodes()
    {
        int countOfNodes = 0;
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
                    else if (!int.TryParse(line, out countOfNodes))
                        fileStatus = FileStatus.FsWrongDataType;
                    else if (countOfNodes < 1)
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

        return countOfNodes;
    }
    
    public int InputCountOfEdges()
    {
        int countOfEdges = 0;
        String? line = null;
        try
        {
            using (StreamReader reader = new StreamReader(filePath))
            {
                try
                {
                    reader.ReadLine(); // skip reading size
                    line = reader.ReadLine();
                    if (line == null)
                        fileStatus = FileStatus.FsEmpty;
                    else if (!int.TryParse(line, out countOfEdges))
                        fileStatus = FileStatus.FsWrongDataType;
                    else if (countOfEdges < 1)
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

        return countOfEdges;
    }

    public void MakeWrongData()
    {
        fileStatus = FileStatus.FsWrongDataType;
    }
    public Edge[] InputEdges(int size)
    {
        String? line = null;
        String[] strElements;
        const int ARGUMENTS = 3;
        char splitter = ' ';
        Edge[] edges = new Edge[size];
        int number;
        try
        {
            using (StreamReader reader = new StreamReader(filePath))
            {
                try
                {
                    reader.ReadLine(); reader.ReadLine(); // skip reading size
                    for (int i = 0; i < size; i++)
                    {
                        if (fileStatus == FileStatus.FsGood)
                        {
                            strElements = reader.ReadLine().Split(splitter);
                            if (strElements.Length == ARGUMENTS)
                            {
                                if (int.TryParse(strElements[0], out number))
                                    edges[i].a = number;
                                else
                                    fileStatus = FileStatus.FsWrongDataType;
                                if (int.TryParse(strElements[1], out number))
                                    edges[i].b = number;
                                else
                                    fileStatus = FileStatus.FsWrongDataType;
                                if (int.TryParse(strElements[2], out number))
                                    edges[i].weight = number;
                                else
                                    fileStatus = FileStatus.FsWrongDataType;
                            }    
                            else
                                fileStatus = FileStatus.FsWrongCount;
                        }
                    }
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

        return edges;

    }
}