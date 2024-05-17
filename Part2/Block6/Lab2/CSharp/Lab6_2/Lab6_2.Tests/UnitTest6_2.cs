using JetBrains.Annotations;
using Lab6_2;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Lab6_2.Tests;

[TestClass]
[TestSubject(typeof(FileReader))]
public class FileReaderTests
{
    private static FileReader fileReader = new FileReader();  

    [TestMethod]
    public void CheckFileStatus_givenOnlyWriteFile_FsNotReadable()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\onlyWriteFile.txt";
        fileReader.InputSizeOfSquare();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsNotReadable);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenMp3File_FsNotTxt()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\music.mp3";
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsNotTxt);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenUnexistenFile_FsNotFound()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\NotExist.txt";
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsNotFound);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongSizeFile_FsWrongDataType()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongSizeFile.txt";
        fileReader.InputSizeOfSquare();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenEvenSizeFile_FsWrongDataType()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongTypeFile.txt";
        fileReader.InputSizeOfSquare();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenEmptyFile_FsEmpty()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\EmptyFile.txt";
        fileReader.InputSizeOfSquare();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsEmpty);
    }
}

[TestClass]
[TestSubject(typeof(FileWriter))]
public class FileWriterTests
{
    private static FileWriter fileWriter = new FileWriter();
    
    [TestMethod]
    public void CheckFileStatus_givenOnlyReadFile_FsNotWritable()
    {
        fileWriter.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\onlyReadFile.txt";
        int[,] testArr = new int[3,3]{ {2,7,6},{9,5,1}, {4,3,8} };
        fileWriter.Output(testArr,3);
        Assert.AreEqual( fileWriter.FileStatus,FileStatus.FsNotWritable);
    }   
    
    [TestMethod]
    public void CheckFileStatus_givenMp3File_FsNotTxt()
    {
        fileWriter.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\music.mp3";
        Assert.AreEqual(fileWriter.FileStatus,FileStatus.FsNotTxt);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenUnexistenFile_FsNotFound()
    {
        fileWriter.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\NotExist.txt";
        Assert.AreEqual(fileWriter.FileStatus,FileStatus.FsNotFound);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWriteFile_FsGood()
    {
        fileWriter.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\OnlyWriteFile.txt";
        Assert.AreEqual(fileWriter.FileStatus,FileStatus.FsGood);
    }
}

[TestClass]
[TestSubject(typeof(MSquareBuilder))]
public class MSquareBuilderTests
{
    [TestMethod]
    public void FindValues_givenUIntTree_Equal()
    {
        const int size = 7;
        int[,] answerArr = new int[size,size];
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                answerArr[i,j] = 0;
            }    
        }
        answerArr[3, 6] = 2;
        answerArr[4, 5] = 1;
        answerArr[5, 6] = 6;
        int[,] testArr = new int[size, size];
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                testArr[i,j] = 0;
            }    
        }
        testArr[3, 1] = 2;
        testArr[4, 0] = 1;
        testArr[5, 1] = 6;
        MSquareBuilder builder = new MSquareBuilder(size);
        builder.MoveLeftPart();
        CollectionAssert.AreEquivalent(builder.Matrix,answerArr);
    }
    
    [TestMethod]
    public void FindValues_givenIntTree_Equal()
    {
        Tree<int> testTree = new Tree<int>();
        testTree.Add(10);
        testTree.Add(20);
        testTree.Add(-5);
        testTree.Add(3);
        testTree.Add(42);
        List<int> answer = new List<int>() { -5, 20 };
        CollectionAssert.AreEquivalent(testTree.FindValues(),answer);
    }
    
    [TestMethod]
    public void FindValues_givenDoubleTree_Equal()
    {
        Tree<double> testTree = new Tree<double>();
        testTree.Add(10.5);
        testTree.Add(10.2);
        testTree.Add(10.7);
        testTree.Add(-3.234);
        testTree.Add(42.24);
        List<double> answer = new List<double>() { 10.2, 10.7 };
        CollectionAssert.AreEquivalent(testTree.FindValues(),answer);
    }
    
    [TestMethod]
    public void FindValues_givenCharTree_Equal()
    {
        Tree<char> testTree = new Tree<char>();
        testTree.Add('g');
        testTree.Add('d');
        testTree.Add('i');
        testTree.Add('z');
        testTree.Add('h');
        testTree.Add('a');
        List<char> answer = new List<char>() { 'd' };
        CollectionAssert.AreEquivalent(testTree.FindValues(),answer);
    }
}
