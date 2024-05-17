package org.example;

public abstract class MyReader {
    public abstract int[] inputArray(final int Size);

    public abstract int inputSize();

    public void invalidTypeMessage(){
        System.err.println("Invalid type! Try again.");
    }
    public void emptyStringMessage()
    {
        System.err.println("Your string Empty! Try again.");
    }
}

