import java.util.Scanner;

public class Main {
    public final static Scanner in = new Scanner(System.in);

    static Reader inputMethod(){
        Reader reader = null;
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
                reader = new FileReader();
                isIncorrect = false;
            }
            // wrong input
            else {
                System.err.println("The word " + choice + " don't match any of method to input the data.");
            }
        } while(isIncorrect);
        return reader;
    }

    static Writer outputMethod() {
        Writer writer = null;
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
                writer = new FileWriter();
                isIncorrect = false;
            }
            else // wrong input
                System.err.println("The word '" + choice + "' don't match any of method to output the data.");
        } while(isIncorrect);
        return writer;
    }

    public static String findNumberInString(String s) {
        boolean isNumber = false;
        boolean wasNumber = false;
        String number = "";
        for (int i = 0; i < s.length(); i++)
        {
            if (!wasNumber && (s.charAt(i) == '+' || s.charAt(i) == '-')) {
                isNumber = true;
                number = "";
                number += s.charAt(i);
            }
            else if (isNumber && Character.isDigit(s.charAt(i))) {
                number += s.charAt(i);
                wasNumber = true;
            }
            else if (isNumber && wasNumber) {
                isNumber = false;
            }
            else if (!wasNumber) {
                isNumber = false;
            }
        }
        // if number == "-" or number == "+" we return empty number
        return (wasNumber) ? number : "\0" ;
    }

    public static void main(String[] args)
    {

        Reader reader = inputMethod();
        String answer= findNumberInString(reader.inputString());
        Writer writer = outputMethod();
        writer.outputString(answer);
        in.close();
    }
}

