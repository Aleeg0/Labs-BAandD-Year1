using System;
using System.Collections.Generic;
using JetBrains.Annotations;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Lab7_2;
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
        fileReader.InputCountOfEdges();
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
        fileReader.InputCountOfNodes();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsWrongDataType()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongTypeFile.txt";
        fileReader.InputEdges(fileReader.InputCountOfEdges());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenEmptyFile_FsEmpty()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\EmptyFile.txt";
        fileReader.InputCountOfNodes();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsEmpty);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsGood()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFile.txt";
        fileReader.InputEdges(fileReader.InputCountOfEdges());
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
        int[] temp = { 1, 5, 42, 4, 1 };
        fileWriter.Output(temp);
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
    private static FileReader fileReader = new FileReader();
    
    [TestMethod]
    public void FindPath_givenEasyArrayWithoutSignedNumbers_True()
    {
        const int START = 4;
        const int FINISH = 2;
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFileEasyUnSigned.txt";
        int[] answer = { 4,0,1,2 };
        CollectionAssert.AreEquivalent(Solver.FindPath(fileReader.InputCountOfNodes(),fileReader.InputEdges(fileReader.InputCountOfEdges()),START,FINISH),answer);
    }
    
    [TestMethod]
    public void FindPath_givenEasyArrayWithSignedNumbers_True()
    {
        const int START = 4;
        const int FINISH = 2;
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFileEasySigned.txt";
        int[] answer = { 4,3,0,1,2 };
        CollectionAssert.AreEquivalent(Solver.FindPath(fileReader.InputCountOfNodes(),fileReader.InputEdges(fileReader.InputCountOfEdges()),START,FINISH),answer);
    }
    
    [TestMethod]
    public void FindPath_givenHardArrayWithSignedNumbers_True()
    {
        const int START = 5;
        const int FINISH = 11;
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFileHard.txt";
        int[] answer = { 5,6,10,11 };
        CollectionAssert.AreEquivalent(Solver.FindPath(fileReader.InputCountOfNodes(),fileReader.InputEdges(fileReader.InputCountOfEdges()),START,FINISH),answer);
    }
    
    [TestMethod]
    public void FindUnexistedPath_givenHardArrayWithSignedNumbers_True()
    {
        const int START = 2;
        const int FINISH = 4;
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFileHard.txt";
        int[] answer = {4};
        CollectionAssert.AreEquivalent(Solver.FindPath(fileReader.InputCountOfNodes(),fileReader.InputEdges(fileReader.InputCountOfEdges()),START,FINISH),answer);
    }
}