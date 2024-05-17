using ConsoleApp1;
using JetBrains.Annotations;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Lab_4_2.Tests;

[TestClass]
[TestSubject(typeof(FileReader))]
public class FileReaderTests
{
    private static FileReader fileReader = new FileReader();  

    [TestMethod]
    public void CheckFileStatus_givenOnlyWriteFile_FsNotReadable()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\onlyWriteFile.txt";
        fileReader.InputSizeOfArr();
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
        fileReader.InputSizeOfArr();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongCountFile_FsWrongCount()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongCountFile.txt";
        fileReader.InputElementsOfArr(fileReader.InputSizeOfArr());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongCount);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsWrongDataType()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\WrongTypeFile.txt";
        fileReader.InputElementsOfArr(fileReader.InputSizeOfArr());
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsWrongDataType);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenEmptyFile_FsEmpty()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\EmptyFile.txt";
        fileReader.InputSizeOfArr();
        Assert.AreEqual(fileReader.FileStatus,FileStatus.FsEmpty);
    }
    
    [TestMethod]
    public void CheckFileStatus_givenWrongElementFile_FsGood()
    {
        fileReader.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFile.txt";
        fileReader.InputElementsOfArr(fileReader.InputSizeOfArr());
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
        int[] arr = [1, 2, 3, 4];
        fileWriter.Output(arr);
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
    public void CheckFileStatus_givenWrongElementFile_FsGood()
    {
        fileWriter.FilePath = "D:\\Уроки\\Уник\\ОАиП\\Лабы\\GoodFile.txt";
        Assert.AreEqual(fileWriter.FileStatus,FileStatus.FsGood);
    }
}

[TestClass]
[TestSubject(typeof(Sorter))]
public class QuickSortTest
{
    private static Sorter sorter = new Sorter(); 
    [TestMethod]
    public void QuickSort_SortedArray_TheSameArray()
    {
        int[] testArray = [-1,0,121,224,636,800,12121];
        sorter.QuickSort(ref testArray,0,testArray.Length - 1);
        int[] answer = [-1,0,121,224,636,800,12121];
        CollectionAssert.AreEquivalent(testArray,answer);
    }
    
    [TestMethod]
    public void QuickSort_UnSortedArrayOfUnsignedNumbers_SortedArray()
    {
        int[] testArray = [12121,10,121,0,224,800,636];
        sorter.QuickSort(ref testArray,0,testArray.Length - 1);
        int[] answer = [0,10,121,224,636,800,12121];
        CollectionAssert.AreEquivalent(testArray,answer);
    }   
    
    [TestMethod]
    public void QuickSort_UnSortedArrayOfAllNumbers_SortedArray()
    {
        int[] testArray = [12121,-21512,121,0,-2552,224,800,636];
        sorter.QuickSort(ref testArray,0,testArray.Length - 1);
        int[] answer = [-21512,-2552,0,121,224,636,800,12121];
        CollectionAssert.AreEquivalent(testArray,answer);
    }  
    
    [TestMethod]
    public void QuickSort_UnSortedArrayOfUnsignedNumbersWithDuplicates_SortedArray()
    {
        int[] testArray = [800,12121,10,121,0,224,800,10,636];
        sorter.QuickSort(ref testArray,0,testArray.Length - 1);
        int[] answer = [0,10,10,121,224,636,800,800,12121];
        CollectionAssert.AreEquivalent(testArray,answer);
    }  
    
    [TestMethod]
    public void QuickSort_UnSortedArrayOfAllNumbersWithDuplicates_SortedArray()
    {
        int[] testArray = [0,12121,-21512,121,0,-2552,224,800,-21512,636];
        sorter.QuickSort(ref testArray,0,testArray.Length - 1);
        int[] answer = [-21512,-21512,-2552,0,0,121,224,636,800,12121];
        CollectionAssert.AreEquivalent(answer,testArray);
    }  
    
}