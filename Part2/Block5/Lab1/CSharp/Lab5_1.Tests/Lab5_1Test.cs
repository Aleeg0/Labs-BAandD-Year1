using System.Collections.Generic;
using JetBrains.Annotations;
using Lab5_1;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Lab5_1.Tests;

[TestClass]
[TestSubject(typeof(FileReader))]
public class FileReaderTests
{
    private static FileReader fileReader = new FileReader();  

    [TestMethod]
    public void CheckFileStatus_givenOnlyWriteFile_FsNotReadable()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\onlyWriteFile.txt";
        fileReader.InputSizeOfList();
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
        fileReader.InputSizeOfList();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongCountFile_FsWrongCount()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongCountFile.txt";
        fileReader.InputElementsOfList(fileReader.InputSizeOfList());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongCount);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsWrongDataType()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongTypeFile.txt";
        fileReader.InputElementsOfList(fileReader.InputSizeOfList());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenEmptyFile_FsEmpty()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\EmptyFile.txt";
        fileReader.InputSizeOfList();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsEmpty);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsGood()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFile.txt";
        fileReader.InputElementsOfList(fileReader.InputSizeOfList());
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
[TestSubject(typeof(Merger))]
public class MergeTowListsTest
{
    private static Merger merger = new Merger(); 
    [TestMethod]
    public void MergeTwoLists_givenTwoEqualsLists_SortedArray()
    {
        List<int> testList1 = new List<int>(){1,1,2,3};
        List<int> testList2 = new List<int>(){1,1,2,3};
        List<int> answer = new List<int>(){1,1,1,1,2,2,3,3};
        CollectionAssert.AreEquivalent(merger.MergeTwoLists(testList1,testList2),answer);
    }
    
    [TestMethod]
    public void MergeTwoLists_givenTwoListsOfUnsignedNumbers_SortedArray()
    {
        List<int> testList1 = new List<int>(){1,5,6,7};
        List<int> testList2 = new List<int>(){2,4,9,15};
        List<int> answer = new List<int>(){1,2,4,5,6,7,9,15};
        CollectionAssert.AreEquivalent(merger.MergeTwoLists(testList1,testList2),answer);
    }   
    
    [TestMethod]
    public void MergeTwoLists_givenTwoListsOfAllNumbers_SortedArray()
    {
        List<int> testList1 = new List<int>(){-1,1,7,12512};
        List<int> testList2 = new List<int>(){-5,0,101,3376};
        List<int> answer = new List<int>(){-5,-1,0,1,7,101,12512,3376};
        CollectionAssert.AreEquivalent(merger.MergeTwoLists(testList1,testList2),answer);
    }  
    
    [TestMethod]
    public void MergeTwoLists_givenTwoListsOfUnsignedNumbersWithDuplicates_SortedArray()
    {
        List<int> testList1 = new List<int>(){1,5,6,7,7};
        List<int> testList2 = new List<int>(){2,5,9,15};
        List<int> answer = new List<int>(){1,2,5,5,6,7,7,9,15};
        CollectionAssert.AreEquivalent(merger.MergeTwoLists(testList1,testList2),answer);
    }

    [TestMethod]
    public void MergeTwoLists_givenTwoListsOfAllNumbersWithDuplicates_SortedArray()
    {
        List<int> testList1 = new List<int>() { -1, 1, 7, 101, 12512 };
        List<int> testList2 = new List<int>() { -5, 1, 0, 101, 3376 };
        List<int> answer = new List<int>() { -5, -1, 0, 1, 1, 7, 101, 101, 12512, 3376 };
        CollectionAssert.AreEquivalent(merger.MergeTwoLists(testList1, testList2), answer);
    }
}

[TestClass]
[TestSubject(typeof(Merger))]
public class IsListDecreasing
{
    private static Merger merger = new Merger(); 
    [TestMethod]
    public void isListDecreasing_givenIncreasingListsOfAllNumbers_False()
    {
        Assert.IsFalse(merger.IsListDecreasing(new List<int>() { -1, 1, 7, 101, 12512 }));
    }
    [TestMethod]
    public void isListDecreasing_givenDecreasingListsOfAllNumbers_True()
    {
        Assert.IsTrue(merger.IsListDecreasing(new List<int>() { -1, 1, -5, 101, 12512 }));
    }
    [TestMethod]
    public void isListDecreasing_givenDecreasingListsOfAllNumbersWithDuplicates_True()
    {
        Assert.IsTrue(merger.IsListDecreasing(new List<int>() { -1, 1 ,1,-5, -5, 101, 12512 }));
    }
    [TestMethod]
    public void isListDecreasing_givenIncreasingListsOfAllNumbersWithDuplicates_True()
    {
        Assert.IsFalse(merger.IsListDecreasing(new List<int>() { -1, 1, 7, 7, 101, 12512 }));
    }
}