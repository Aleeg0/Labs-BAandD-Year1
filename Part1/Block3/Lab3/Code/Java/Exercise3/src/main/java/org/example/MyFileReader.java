package org.example;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class MyFileReader extends MyReader {
    private String fileName;

    private boolean status;
    MyFileReader()
    {}
    MyFileReader(String fileName){
        this.fileName = fileName;
    }

    public boolean getStatus() {
        return status;
    }

    @Override
    public int inputSize() {
        int size = 0;
        char currentChar = '\0';
        boolean wasNumber = false;
        boolean isCorrect = false; // for exit the loop
        String number = ""; // string for parse Number
        int codeOfChar = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
            while(status && !isCorrect && (codeOfChar = reader.read()) != -1) {
                currentChar = (char)(codeOfChar);
                if (Character.isAlphabetic(currentChar)) {
                    invalidTypeMessage();
                    status = false;
                    wasNumber = false;
                }
                else if ((Character.isDigit(currentChar))) {
                    number += currentChar;
                    wasNumber = true;
                }
                else if (wasNumber) {
                    size = Integer.parseInt(number);
                    isCorrect = true;
                }
            }
        }
        catch(IOException ex){
            System.err.println("Oops! Something went wrong.");
        }
        if (size < Main.MIN_SIZE && wasNumber)
        {
            System.err.printf("Matrix order cannot be less than %d.\n", Main.MIN_SIZE);
            status = false;
        }
        return size;
    }
    @Override
    public int[] inputArray(final int size) {
        boolean isIncorrect = true;
        char currentChar = '\0';
        boolean wasNumber = false;
        boolean isCorrect = false; // for exit the loop
        String number = ""; // string for parse Number
        int character = 0;
        int counter = 0;
        int[] array = new int[size]; // memory allocation
        try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
            reader.readLine();
            for (int i = 0; i < size; i++) {
                isCorrect = false;
                while (status && !isCorrect && (character = reader.read()) != -1) {
                    currentChar = (char) (character);
                    if (Character.isAlphabetic(currentChar)) {
                        invalidTypeMessage();
                        status = false;
                    } else if ((Character.isDigit(currentChar)) || currentChar == '.') {
                        number += currentChar;
                        wasNumber = true;
                    } else if (wasNumber) {
                        array[i] = Integer.parseInt(number);
                        number = "";
                        isCorrect = true;
                        counter++;
                    }
                }
                if (!number.isEmpty()){
                    array[i] = Integer.parseInt(number);
                    counter++;
                }
            }
        } catch (IOException ex) {
            System.err.println("Oops! Something went wrong.");
        }
        if (counter != size){
            status = false;
            System.err.println("Function didn't found all numbers.");
        }
        return array;
    }

    public void setFileName(){
        do {
            System.out.println("Enter the name of file in this directory or path to this file including name of file:");
            fileName = Main.in.nextLine();
        }while(!isFileGood());
    }
    public boolean isFileGood() {
        status = false;
        File inputfile = new File(fileName);
        // if file doesn't exist
        if (!inputfile.exists()) {
            System.err.println("This file or the path to the file is specified incorrectly or does not exist! Try again.");
        }
        // if file isn't .txt
        else if (!fileName.endsWith(".txt")) {
            System.err.println("This file or path to the file isn't .txt! Try again.");
        }
        else if (!inputfile.canRead()) {
            System.err.println("The program can't read this file! Try again.");
        }
        else if (inputfile.length() == 0){
            emptyStringMessage();
        }
        else {
            status = true;
        }
        return status;
    }
}
