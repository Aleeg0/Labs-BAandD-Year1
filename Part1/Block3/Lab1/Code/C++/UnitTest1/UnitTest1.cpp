#include "pch.h"
#include "CppUnitTest.h"
#include "..\Exercise 1\Exercise 1.cpp" //attach our task

using namespace Microsoft::VisualStudio::CppUnitTestFramework;


namespace UnitTest1
{
    //Checking the function findNumberInString()
    TEST_CLASS(MainFunction)
    {
    public:
        TEST_METHOD(TestMethod1)
        {
            Assert::AreEqual(findNumberInString("asfasfa+10asf"), (std::string)"+10");
        }
        TEST_METHOD(TestMethod2)
        {
            Assert::AreEqual(findNumberInString("asffa_-125.245241"), (std::string)"-125");
        }
        TEST_METHOD(TestMethod3)
        {
            Assert::AreEqual(findNumberInString("hjkjhlk-+-+25asfasf+10"), (std::string)"+25");
        }
        TEST_METHOD(TestMethod4)
        {
            Assert::AreEqual(findNumberInString("-1fsafasfsaf"), (std::string)"-1");
        }
        TEST_METHOD(TestMethod5)
        {
            Assert::AreEqual(findNumberInString("ыавыфаasf-.222222+++++5"), (std::string)"+5");
        }
        TEST_METHOD(TestMethod6)
        {
            Assert::AreEqual(findNumberInString("asfsf12fassff-.222-+-+fasfasf"), (std::string)"\0");
        }
    };
    //Checking the functions which check the correct of file
    File* testFile = nullptr;
    //checking the function isFileTxt();
    TEST_CLASS(IsFileTxt)
    {
    public:
        TEST_METHOD(TestMethod1)
        {
            testFile = new File("music.mp3", (size_t)0);
            Assert::AreEqual(testFile->isFileText(), false);
            delete testFile;
        }
        TEST_METHOD(TestMethod2)
        {
            testFile = new File("input.txt", (size_t)0);
            Assert::AreEqual(testFile->isFileText(), true);
            delete testFile;
        }
        TEST_METHOD(TestMethod3)
        {
            testFile = new File("output.txt", (size_t)1);
            Assert::AreEqual(testFile->isFileText(), true);
            delete testFile;
        }
    };
    //checking the function isFileExist()
    //to check this function you need some files on your device
    TEST_CLASS(IsFileExist)
    {
    public:
        TEST_METHOD(TestMethod1)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\music.mp3", (size_t)0);
            Assert::AreEqual(testFile->isFileExist(), true);
            delete testFile;
        }
        TEST_METHOD(TestMethod2)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input124.txt", (size_t)0);
            Assert::AreEqual(testFile->isFileExist(), false);
            delete testFile;
        }
        TEST_METHOD(TestMethod3)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\output.txt", (size_t)1);
            Assert::AreEqual(testFile->isFileExist(), true);
            delete testFile;
        }
    };
    //checking the function isNotEmpty()
    //to check this function you need some files on your device
    TEST_CLASS(IsFileNotEmpty)
    {
    public:
        TEST_METHOD(TestMethod1)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input.txt", (size_t)0);

            Assert::AreEqual(testFile->isNotEmpty(), false);
            delete testFile;
        }
        TEST_METHOD(TestMethod2)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input1.txt", (size_t)0);
            testFile->isGood();
            Assert::AreEqual(testFile->isNotEmpty(), true);
            delete testFile;
        }
    };
    //checking the function isGood()
    //this function including 5 functions 
    // 1 - isFileExist()
    // 2 - isFileTxt()
    // 3 - isNotEmpty() - Only works when file has fileCode = 0 
    // 4 - isFileReadable() - Only works when file has fileCode = 0
    // 5 - isFileWritable() - Only works when file has fileCode = 1
    // 
    TEST_CLASS(IsFileGood)
    {
    public:
        TEST_METHOD(TestMethod1)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\music.mp3", (size_t)0);
            Assert::AreEqual(testFile->isGood(), false);
            delete testFile;
        }
        TEST_METHOD(TestMethod2)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input124.txt", (size_t)0);
            Assert::AreEqual(testFile->isGood(), false);
            delete testFile;
        }
        TEST_METHOD(TestMethod3)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input.txt", (size_t)0);
            Assert::AreEqual(testFile->isGood(), false);
            delete testFile;
        }
        TEST_METHOD(TestMethod4)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input1.txt", (size_t)0);
            Assert::AreEqual(testFile->isGood(), true);
            delete testFile;
        }
    };
    //checking the function getString()
    TEST_CLASS(getString)
    {
    public:
        TEST_METHOD(TestMethod1)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input1.txt", (size_t)0);
            testFile->isGood();
            Assert::AreEqual(testFile->getString(), (std::string)("gdsgdsdsf-.222222+++++5"));
            delete testFile;
        }
        TEST_METHOD(TestMethod2)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input2.txt", (size_t)0);
            testFile->isGood();
            Assert::AreEqual(testFile->getString(), (std::string)("hjkjhlk-+-+25asfasf+10"));
            delete testFile;
        }
    };
    //checking the function isFileWroking()
    TEST_CLASS(isWorking)
    {
    public:
        TEST_METHOD(TestMethod1)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\outputRead.txt", (size_t)0);
            testFile->isGood();
            Assert::AreEqual(testFile->isFileWorking(), false);
            delete testFile;
        }
        TEST_METHOD(TestMethod2)
        {
            testFile = new File("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба1\\Code\\C++\\Exercise 1\\input1.txt", (size_t)0);
            testFile->isGood();
            Assert::AreEqual(testFile->isFileWorking(), true);
            delete testFile;
        }
    };
}
