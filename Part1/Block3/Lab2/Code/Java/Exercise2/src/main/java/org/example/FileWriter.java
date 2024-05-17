package org.example;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.util.HashSet;

public class FileWriter extends Writer {

    private String fileName;

    private boolean status;
    FileWriter()
    {}
    FileWriter(String fileName){
        this.fileName = fileName;
    }
    public boolean isFileGood()
    {
        status = false;
        File inputfile = new File(fileName);;
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

    @Override
    public void outputSet(HashSet<Character> set) {
        boolean isIncorrect = true;
        do {
            System.out.println("Enter the name of file in this directory or path to this file including name of file:");
            fileName = Main.in.nextLine();
            if (isFileGood()) {
                try (BufferedWriter out = new BufferedWriter(new java.io.FileWriter(fileName))){
                    if (!set.isEmpty()){
                        out.write("Function found this symbols in the inputted string.\n");
                        for (Character symbol: set) {
                            out.write(symbol + " ");
                        }
                        out.write('\n');
                    }
                    else{
                        out.write("Function didn't find symbols in string.\n");
                    }
                    System.out.println("Answer has been wrote successfully.");
                    isIncorrect = false;
                }
                catch (IOException ex) {
                    System.err.println("Oops! Something went wrong.");
                }
            }
        }while(isIncorrect);
    }
}
