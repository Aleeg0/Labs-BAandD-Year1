using System;
using System.Collections.Generic;
using JetBrains.Annotations;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Lab7_1;
using Microsoft.VisualStudio.TestPlatform.TestHost;


[TestClass]
[TestSubject(typeof(FileReader))]
public class FileReaderTests
{
    private static FileReader fileReader = new FileReader();  

    [TestMethod]
    public void CheckFileStatus_givenOnlyWriteFile_FsNotReadable()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\onlyWriteFile.txt";
        fileReader.InputSizeOfNodes();
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
        fileReader.InputSizeOfNodes();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsWrongDataType()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongTypeFile.txt";
        fileReader.InputElements(fileReader.InputSizeOfNodes());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenEmptyFile_FsEmpty()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\EmptyFile.txt";
        fileReader.InputSizeOfNodes();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsEmpty);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsGood()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFile.txt";
        fileReader.InputElements(fileReader.InputSizeOfNodes());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsGood);
    }
}

[TestClass]
[TestSubject(typeof(FileWriter))]
public class FileWriterTexts
{
    private static FileWriter fileWriter = new FileWriter();
    
    [TestMethod]
    public void CheckFileStatus_givenOnlyReadFile_FsNotWritable()
    {
        fileWriter.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\onlyReadFile.txt";
        const int SIZE = 3;
        int[,] testMatrix = { {0,1,0},{1,0,0},{0,0,0} };
        fileWriter.Output(testMatrix,SIZE);
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
[TestSubject(typeof(Solver))]
public class SolverTest
{

    [TestMethod]
    public void BuildMatrix_givenSize2Numbers_Equal()
    {
        LinkedList<LinkedList<int>> allNodes = new LinkedList<LinkedList<int>>();
        int SIZE = 2;
        LinkedList<int> tempList1 = new LinkedList<int>();
        tempList1.AddLast(2);
        allNodes.AddLast(tempList1);
        LinkedList<int> tempList2 = new LinkedList<int>();
        tempList2.AddLast(1);
        allNodes.AddLast(tempList2);
        int[,] answer = { { 0, 1 }, { 1, 0 } };
        CollectionAssert.AreEquivalent(Solver.BuildMatrix(allNodes, SIZE),answer);
    }
    [TestMethod] 
    public void BuildMatrix_givenSize2Numbers_Not_Equal()
    {
        LinkedList<LinkedList<int>> allNodes = new LinkedList<LinkedList<int>>();
        int SIZE = 2;
        LinkedList<int> tempList1 = new LinkedList<int>();
        tempList1.AddLast(1);
        tempList1.AddLast(2);
        allNodes.AddLast(tempList1);
        LinkedList<int> tempList2 = new LinkedList<int>();
        tempList2.AddLast(1);
        tempList2.AddLast(2);
        allNodes.AddLast(tempList2);
        int[,] answer = { { 0, 1 }, { 1, 0 } };
        CollectionAssert.AreNotEquivalent(Solver.BuildMatrix(allNodes, SIZE),answer);
    }
    
    [TestMethod]
    public void BuildMatrix_givenSize3Numbers_Equal()
    {
        LinkedList<LinkedList<int>> allNodes = new LinkedList<LinkedList<int>>();
        int SIZE = 3;
        LinkedList<int> tempList1 = new LinkedList<int>();
        tempList1.AddLast(1);
        tempList1.AddLast(3);
        allNodes.AddLast(tempList1);
        LinkedList<int> tempList2 = new LinkedList<int>();
        tempList2.AddLast(1);
        allNodes.AddLast(tempList2);
        int[,] answer = { { 1, 0, 1 }, { 0, 0, 0 }, { 1, 0, 0 } };
        CollectionAssert.AreEquivalent(Solver.BuildMatrix(allNodes, SIZE),answer);
    }
    
    [TestMethod]
    public void BuildMatrix_givenSize3Numbers_NotEqual()
    {
        LinkedList<LinkedList<int>> allNodes = new LinkedList<LinkedList<int>>();
        int SIZE = 3;
        LinkedList<int> tempList1 = new LinkedList<int>();
        tempList1.AddLast(1);
        allNodes.AddLast(tempList1);
        LinkedList<int> tempList2 = new LinkedList<int>();
        tempList2.AddLast(1);
        allNodes.AddLast(tempList2);
        LinkedList<int> tempList3 = new LinkedList<int>();
        tempList3.AddLast(1);
        allNodes.AddLast(tempList3);
        int[,] answer = { { 1, 0, 1 }, { 0, 0, 0 }, { 0, 0, 1 } };
        CollectionAssert.AreEquivalent(Solver.BuildMatrix(allNodes, SIZE),answer);
    }
}