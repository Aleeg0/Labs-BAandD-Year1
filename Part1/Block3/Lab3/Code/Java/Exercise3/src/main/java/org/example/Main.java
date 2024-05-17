package org.example;

import java.util.Scanner;

public class Main {

    //const
    final static int MIN_SIZE = 2;
    static Scanner in  = new Scanner(System.in);

    //functions for input
    static MyReader inputMethod(){
        MyReader reader = null;
        boolean isIncorrect = true;
        String choice = "";
        System.out.println("The program works with console input or files.");
        do {
            System.out.print("""
                    To use console enter 'console'.
                    To use a file enter 'file'.
                    Enter what type you want to use:
                    """);
            choice = in.nextLine();
            if (choice.equals("console")) {
                reader = new ConsoleReader();
                isIncorrect = false;
            }
            else if (choice.equals("file")) {
                reader = new MyFileReader();
                isIncorrect = false;
            }
            // wrong input
            else {
                System.err.println("The word " + choice + " don't match any of method to input the data.");
            }
        } while(isIncorrect);
        return reader;
    }

    static MyWriter outputMethod() {
        MyWriter writer = null;
        boolean isIncorrect = true;
        String choice = "";
        System.out.println("The program is ready to show answer.");
        do {
            System.out.print("""
                    To output in console enter 'console'.
                    To output in a file enter 'file'.
                    Enter what type you want to use:
                    """);
            choice = in.nextLine();
            if (choice.equals("console"))
            {
                writer = new ConsoleWriter();
                isIncorrect = false;
            }
            else if (choice.equals("file"))
            {
                writer = new MyFileWriter();
                isIncorrect = false;
            }
            else // wrong input
                System.err.println("The word '" + choice + "' don't match any of method to output the data.");
        } while(isIncorrect);
        return writer;
    }


    //functions for margeSort
    public static int min(int first, int second){
        return ((first < second) ? first : second);
    }

    public static void marge(int[] arr, int beg1,int end1,int beg2,int end2){
        int left = 0;
        int right = beg2 - beg1;
        int size = end2-beg1 + 1;
        int[] copyArr = new int[size];
        //copy part of array
        for (int i = 0; i < size; i++) {
            copyArr[i] = arr[beg1 + i];
        }
        for (int i = beg1; i < beg1 + size; i++){
            if (left+beg1 > end1){
                arr[i] =  copyArr[right++];
            }
            else if (right + beg1 > end2){
                arr[i] = copyArr[left++];
            }
            else if (copyArr[left] < copyArr[right]) {
                arr[i] = copyArr[left++];
            }
            else {
                arr[i] = copyArr[right++];
            }
        }
    }

    public static void margeSort(int[] arr, int beg, int end){
        int step = 1;
        while (step < end){
            for (int j = beg; j < end - step; j += step * 2){
                marge(arr,j,j+step-1,j+step, min(j + step * 2 - 1, end -1));
            }
            step *= 2;
        }
    }

    public static void inputTask(){
        System.out.println("The program sorts array of integers.");
    }

    public static void main(String[] args) {
        boolean isIncorrect = true;
        int sizeOfArray = 0;
        int[] array = null;
        inputTask();
        MyReader myReader = inputMethod();
        if (myReader instanceof MyFileReader fileReader) {
            do {
                fileReader.setFileName();
                sizeOfArray = fileReader.inputSize();
                if (fileReader.getStatus()) {
                    array = fileReader.inputArray(sizeOfArray);
                }
                if (fileReader.getStatus()) {
                    isIncorrect = false;
                }
                else {
                    System.out.println("Read error was detected in your file.\n" +
                            "This program can't continue to read this file.");
                }
            } while(isIncorrect);
        }
        else {
            sizeOfArray = myReader.inputSize();
            array = myReader.inputArray(sizeOfArray);
        }
        margeSort(array,0,sizeOfArray);
        MyWriter myWriter = outputMethod();
        if (myWriter instanceof MyFileWriter myFileWriter){
            myFileWriter.setFileName();
            myFileWriter.outputArray(array);
        }
        else {
            myWriter.outputArray(array);
        }

    }
}