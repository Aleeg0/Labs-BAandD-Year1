import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;

public class FileWriter extends Writer {

    private String fileName;
    public boolean isFileGood()
    {
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
            return true;
        }
        return false;
    }

    @Override
    public void outputString(String s) {
        boolean isIncorrect = true;
        do {
            System.out.println("Enter the name of file in this directory or path to this file including name of file:");
            fileName = Main.in.nextLine();
            if (isFileGood()) {
                try (BufferedWriter out = new BufferedWriter(new java.io.FileWriter(fileName))){
                    if (s.isEmpty()){
                        out.write("Function didn't find number in string.\n");
                    }
                    else{
                        out.write("The number in the string is" + s + "\n");
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
