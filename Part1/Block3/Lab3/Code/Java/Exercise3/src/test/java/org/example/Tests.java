package org.example;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
class FunctionMinTest {

    @Test
    void Min_FirstMoreThanSecond_FirstNumber(){
        assertEquals(Main.min(10,20),10);
    }

    @Test
    void Min_FirstLowerThanSecond_SecondNumber() {
        assertEquals(Main.min(15,5),5);
    }

    @Test
    void Min_FirstEqualsSecond_FirstNumber() {
        assertEquals(Main.min(1,1),1);
    }
}

class FunctionMargeSort {
    @Test
    void MargeSort_SortedArray_TheSameArray(){

        int[] testArray = {-1,0,121,224,636,800,12121};
        Main.margeSort(testArray,0,7);
        int[] answer = {-1,0,121,224,636,800,12121};
        assertArrayEquals(testArray,answer);
    }
    
    @Test
    void MargeSort_UnSortedArrayOfUnsignedNumbers_SortedArray(){
        int[] testArray = {12121,10,121,0,224,800,636} ;
        Main.margeSort(testArray,0,7);
        int[] answer = {0,10,121,224,636,800,12121};
        assertArrayEquals(testArray,answer);
    }

    @Test
    void MargeSort_UnSortedArrayOfAllNumbers_SortedArray(){
        int[] testArray = {12121,-21512,121,0,-2552,224,800,636};
        Main.margeSort(testArray,0,8);
        int[] answer = {-21512,-2552,0,121,224,636,800,12121};
        assertArrayEquals(testArray,answer);
    }

    @Test
    void MargeSort_UnSortedArrayOfUnsignedNumbersWithDuplicates_SortedArray(){
        int[] testArray = {800,12121,10,121,0,224,800,10,636};
        Main.margeSort(testArray,0,9);
        int[] answer = {0,10,10,121,224,636,800,800,12121};
        assertArrayEquals(testArray,answer);
    }

    @Test
    void MargeSort_UnSortedArrayOfAllNumbersWithDuplicates_SortedArray(){
        int[] testArray = {0,12121,-21512,121,0,-2552,224,800,-21512,636};
        Main.margeSort(testArray,0,10);
        int[] answer = {-21512,-21512,-2552,0,0,121,224,636,800,12121};
        assertArrayEquals(testArray,answer);
    }
}


class FunctionIsFileGoodFromMyFileReader{

    @Test
    void IsFileGood_givenMp3File_False(){
        MyFileReader testFileReader = new MyFileReader("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба3\\Code\\music.mp3");
        assertFalse(testFileReader.isFileGood());
    }

    @Test
    void IsFileGood_givenUnexistFile_False(){
        MyFileReader testFileReader = new MyFileReader("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба3\\Code\\music.txt");
        assertFalse(testFileReader.isFileGood());
    }

    @Test
    void IsFileGood_givenEmptyFile_False(){
        MyFileReader testFileReader = new MyFileReader("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба3\\Code\\input.txt");
        assertFalse(testFileReader.isFileGood());
    }

    @Test
    void IsFileGood_givenGoodFile_True(){
        MyFileReader testFileReader = new MyFileReader("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба3\\Code\\input1.txt");
        assertTrue(testFileReader.isFileGood());
    }

}


class FunctionIsFileGoodFromMyFileWriter{

    @Test
    void IsFileGood_givenMp3File_False(){
        MyFileWriter testFileWriter = new MyFileWriter("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба3\\Code\\music.mp3");
        assertFalse(testFileWriter.isFileGood());
    }

    @Test
    void IsFileGood_givenUnexistFile_False(){
        MyFileWriter testFileWriter = new MyFileWriter("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба3\\Code\\music.txt");
        assertFalse(testFileWriter.isFileGood());
    }

    @Test
    void IsFileGood_givenGoodFile_True(){
        MyFileWriter testFileWriter = new MyFileWriter("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба3\\Code\\output.txt");
        assertTrue(testFileWriter.isFileGood());
    }

}