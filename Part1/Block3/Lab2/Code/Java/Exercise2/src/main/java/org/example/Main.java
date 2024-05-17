package org.example;


import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

public class Main {
    static Scanner in  = new Scanner(System.in);

    private final static HashSet<Character> KEY_SYMBOLS = new HashSet<>(Set.of('[',']','{','}','(',')','+','-','*','/','%'));

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

    static public HashSet<Character> findSymbols(String str) {
        HashSet<Character> answer = new HashSet<>();
        char curChar = '\0';
        for (int i = 0; i < str.length(); i++){
            curChar = str.charAt(i);
            if (KEY_SYMBOLS.contains(curChar) || (Character.isDigit(curChar) && (int)(curChar) % 2 == 0) ) {
                answer.add(curChar);
            }
        }
        return answer;
    }

    static public void inputTask(){
        System.out.println("This program finding the symbols in the string, which you'll input.\n" + "Symbols: ");
        for (char symbol: KEY_SYMBOLS) {
            System.out.print(symbol + " ");
        }
        System.out.println("\nAnd digits that divided without remainder by 2.");
    }

    static public void main(String[] args) {
        inputTask();
        Reader reader = inputMethod();
        HashSet<Character> answer = findSymbols(reader.inputString());
        Writer writer = outputMethod();
        writer.outputSet(answer);
        in.close();
    }
}