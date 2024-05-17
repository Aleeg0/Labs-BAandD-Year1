package org.example;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class MyFileWriter extends MyWriter {

    private String fileName;

    private boolean status;
    MyFileWriter()
    {}
    MyFileWriter(String fileName){
        this.fileName = fileName;
    }
    public boolean isFileGood()
    {
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
        else if (!inputfile.canWrite()) {
            System.err.println("The program can't read this file! Try again.");
        }
        else {
            status = true;
        }
        return status;
    }

    public void setFileName(){
        do {
            System.out.println("Enter the name of file in this directory or path to this file including name of file:");
            fileName = Main.in.nextLine();
        }while(!isFileGood());
    }

    @Override
    public void outputArray(int[] array) {
        try (BufferedWriter out = new BufferedWriter(new FileWriter(fileName))) {
            int size = array.length;
            out.write("Sorted array:\n");
            for (int i = 0; i < size; i++) {
                out.write(array[i] + " ");
            }
            out.write('\n');
            System.out.println("Answer has been wrote successfully.");
        } catch (IOException ex) {
            System.err.println("Oops! Something went wrong.");
        }
    }
}
