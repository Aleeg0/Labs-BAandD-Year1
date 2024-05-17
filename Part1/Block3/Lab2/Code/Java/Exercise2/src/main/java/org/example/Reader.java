package org.example;

public abstract class Reader {
    public abstract String inputString();
    public void emptyStringMessage()
    {
        System.err.println("Your string Empty! Try again.");
    }
}

