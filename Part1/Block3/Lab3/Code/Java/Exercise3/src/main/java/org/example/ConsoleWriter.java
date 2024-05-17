package org.example;

public class ConsoleWriter extends MyWriter {
    @Override
    public void outputArray(int[] array) {
        int size = array.length;
        System.out.println("Sorted array:");
        for (int i = 0; i < size; i++) {
            System.out.print(array[i] + " ");
        }
        System.out.println();
    }
}
