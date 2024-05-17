package org.example;

import java.util.HashSet;

public class ConsoleWriter extends Writer {
    @Override
    public void outputSet(HashSet<Character> set) {
        if (!set.isEmpty()) {
            System.out.println("Function found this symbols in the inputted string.");
            for (char symbol: set) {
                System.out.print(symbol + " ");
            }
            System.out.println();
        }
        else {
            System.out.println("Function didn't find symbols in string.");
        }
    }
}
