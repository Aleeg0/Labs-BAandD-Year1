using System.Collections.Generic;
using JetBrains.Annotations;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Lab5_2;


[TestClass]
[TestSubject(typeof(FileReader))]
public class FileReaderTests
{
    private static FileReader fileReader = new FileReader();  

    [TestMethod]
    public void CheckFileStatus_givenOnlyWriteFile_FsNotReadable()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\onlyWriteFile.txt";
        fileReader.InputSizeOfTree();
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
        fileReader.InputSizeOfTree();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongCountFile_FsWrongCount()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongCountFile.txt";
        fileReader.InputElementsOfTree(fileReader.InputSizeOfTree());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongCount);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsWrongDataType()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongTypeFile.txt";
        fileReader.InputElementsOfTree(fileReader.InputSizeOfTree());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenEmptyFile_FsEmpty()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\EmptyFile.txt";
        fileReader.InputSizeOfTree();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsEmpty);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsGood()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFile.txt";
        fileReader.InputElementsOfTree(fileReader.InputSizeOfTree());
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
        List<int> testList = new List<int>(){1,2,3,4};
        fileWriter.Output(testList);
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
[TestSubject(typeof(Tree<int>))]
public class FindValuesTest
{

    [TestMethod]
    public void FindValues_givenUIntTree_Equal()
    {
        Tree<uint> testTree = new Tree<uint>();
        testTree.Add(10);
        testTree.Add(20);
        testTree.Add(1);
        testTree.Add(3);
        testTree.Add(2);
        testTree.Add(42);
        List<uint> answer = new List<uint>() { 3,1,20,10 };
        CollectionAssert.AreEquivalent(testTree.FindValues(),answer);
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