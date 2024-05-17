package org.example;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class FileWriterTest {
    private static FileWriter writer;

    @Test
    void isFileGood() {
        writer = new FileWriter("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба2\\input414.txt");
        assertFalse(writer.isFileGood());
        writer = new FileWriter("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба2\\music.mp3");
        assertFalse(writer.isFileGood());
        writer = new FileWriter("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба2\\output.txt");
        assertTrue(writer.isFileGood());
    }
}