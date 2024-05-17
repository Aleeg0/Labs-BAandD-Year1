import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;

public class FileReader extends Reader {
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
        else if (!inputfile.canRead()) {
            System.err.println("The program can't read this file! Try again.");
        }
        else {
            return true;
        }
        return false;
    }
    @Override
    public String inputString() {
        boolean isIncorrect = true;
        String inputtedString = "\0";
        do {
            System.out.println("Enter the name of file in this directory or path to this file including name of file:");
            fileName = Main.in.nextLine();
            if (isFileGood()) {
                try (BufferedReader reader = new BufferedReader(new java.io.FileReader(fileName))){
                    inputtedString = reader.readLine();
                    if (inputtedString == null){
                        emptyStringMessage();
                    }
                    else {
                        isIncorrect = false;  // to exit this loop
                    }
                }
                catch (IOException ex) {
                    System.err.println("Oops! Something went wrong.");
                }
            }
        }while(isIncorrect);
        return inputtedString;
    }
}
