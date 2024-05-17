package org.example;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;


class FileReaderTest {
    private static FileReader reader;
    @Test
    void isFileGood() {
        reader = new FileReader("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба2\\input122.txt");
        assertFalse(reader.isFileGood());
        reader = new FileReader("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба2\\music.mp3");
        assertFalse(reader.isFileGood());
        reader = new FileReader("D:\\Уроки\\Уник\\ОАиП\\Лабы\\Блок3\\Лаба2\\input.txt");
        assertTrue(reader.isFileGood());
    }
}