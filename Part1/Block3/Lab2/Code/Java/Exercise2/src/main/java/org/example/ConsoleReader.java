package org.example;
public class ConsoleReader extends Reader {

    @Override
    public String inputString() {
        String inputtedString = "";
        boolean isIncorrect = true;
        System.out.println("Enter string:");
        do {
            inputtedString = Main.in.nextLine();
            if (!inputtedString.isEmpty())
                isIncorrect = false;
            else
                emptyStringMessage();
        } while (isIncorrect);
        return inputtedString;
    }
}

