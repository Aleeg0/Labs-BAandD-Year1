package org.example;
public class ConsoleReader extends MyReader {


    @Override
    public int inputSize(){
        boolean isIncorrect = true;
        int size = 0;
        // asking for Size of array
        do {
            try
            {
                System.out.println("Enter size of array:");
                size = Integer.parseInt(Main.in.nextLine());
                isIncorrect = false;
            }
            catch (NumberFormatException exception)
            {
                invalidTypeMessage();
            }
            if (size < Main.MIN_SIZE) {
                System.err.printf("Size of array cannot be less than %d! Try again.\n", Main.MIN_SIZE);
                isIncorrect = true;
            }
        }while(isIncorrect);
        return size;
    }
    @Override
    public int[] inputArray(final int size) {
        String inputtedString = "";
        boolean isIncorrect = true;
        int inputtedNumber = 0;
        int[] array = new int[size];
        System.out.println("Input array by elements.");
        for (int i = 0; i < size; i++) {
            do {
                try {
                    System.out.println("Enter " + (i + 1) + " element:");
                    inputtedNumber = Integer.parseInt(Main.in.nextLine());
                    array[i] = inputtedNumber;
                    isIncorrect = false;
                } catch (NumberFormatException ex){
                    invalidTypeMessage();
                }
            }while(isIncorrect);
        }
        return array;
    }
}

