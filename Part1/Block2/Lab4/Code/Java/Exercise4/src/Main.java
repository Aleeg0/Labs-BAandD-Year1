import java.io.*;
import java.util.Scanner;

public class Main {
    final static int minMatrixOrder = 3;

    final static Scanner in = new Scanner(System.in);

    public static double[][] initialization(int n)
    {
        return new double[n][n];
    }

    public static boolean inputMethod()
    {
        boolean isIncorrect = true;
        String choice = "\0";
        System.out.println("The program works with console input or files.");
        do
        {
            System.out.print("""
                    To use console enter 'console'.
                    To use a file enter 'file'.
                    Enter what type you want to use:
                    """);
            choice = in.nextLine();
            if (choice.equals("console"))
            {
                return true;
            }
            else if (choice.equals("file"))
            {
                isIncorrect = false;
            }
            else // wrong input
                System.err.println("The word " + choice + " don't match any of method to input the data.");
        } while(isIncorrect);
        return isIncorrect;
    }

    public static int inputSizeOfMatrixFromConsole()
    {
        boolean isIncorrect = true;
        int n = 0;
        // asking for Size of matrix
        do
        {
            try
            {
                System.out.println("Enter the matrix order: ");
                n = Integer.parseInt(in.nextLine());
            }
            catch (NumberFormatException exception)
            {
                System.err.println("Invalid type! Try again.");
            }
            if (n < minMatrixOrder)
            {
                System.err.printf("Matrix order cannot be less than %d! Try again.\n", minMatrixOrder);
            }
            else
                isIncorrect = false;
        } while (isIncorrect);
        return n;
    }

    public static double[][] inputElementsOfMatrixFromConsole(int n)
    {
        double[][] matrix;
        boolean isIncorrect = true;
        // initialization of matrix
        matrix = initialization(n);
        for (int i = 0; i < matrix.length; i++)
        {
            for (int j = 0; j < matrix.length; j++)
            {
                isIncorrect = true;
                do
                {
                    try
                    {
                        System.out.printf("Enter a%d%d:\n",i+1,j+1);
                        matrix[i][j] = Double.parseDouble(in.nextLine());
                        isIncorrect = false;
                    }
                    catch (NumberFormatException exception) {
                        System.err.println("Invalid type! Try again.");
                    }
                } while (isIncorrect);
            }
        }
        return matrix;
    }

    public static String inputReadFileName()
    {
        String fileName = "\0";
        boolean isIncorrect = true;
        File tempFile;
        do
        {
            // Inputting name of file or path to the file including file
            System.out.println("Enter the name of file in this directory or path to this file including name of file:");
            fileName = in.nextLine();
            tempFile = new File(fileName);
            if (!tempFile.exists()) // if file doesn't exist
            {
                System.err.println("This file or the path to the file is specified incorrectly or does not exist! Try again.");
            }
            else if (!fileName.endsWith(".txt")) // if file isn't .txt
            {
                System.err.println("This file or path to the file isn't .txt! Try again.");
            }
            else if (!tempFile.canRead())
            {
                System.err.println("The program can't read this file! Try again.");
            }
            else
            {
                isIncorrect = false;  // to exit this loop
            }
        }while(isIncorrect);
        return fileName;
    }

    public static String inputWriteFileName()
    {
        String fileName = "\0";
        boolean isIncorrect = true;
        File tempFile;
        do
        {
            // Inputting name of file or path to the file including file
            System.out.println("Enter the name of file in this directory or path to this file including name of file:");
            fileName = in.nextLine();
            tempFile = new File(fileName);
            if (!tempFile.exists()) // if file doesn't exist
            {
                System.err.println("This file or the path to the file is specified incorrectly or does not exist! Try again.");
            }
            else if (!fileName.endsWith(".txt")) // if file isn't .txt
            {
                System.err.println("This file or path to the file isn't .txt! Try again.");
            }
            else if (!tempFile.canWrite())
            {
                System.err.println("The program can't read this file! Try again.");
            }
            else
            {
                isIncorrect = false;  // to exit this loop
            }
        }while(isIncorrect);
        return fileName;
    }

    public static Boolean isAnotherFile()
    {
        boolean  isIncorrect = true;
        String userAnswer = "\0";
        System.out.println("Read error was detected in your file.\n" +
                "This program can't continue to read this file.");
        do
        {
            System.out.println("Do you want to change file?(yes/no)");
            userAnswer = in.nextLine();
            if (userAnswer.equals("yes"))
            {
                return true;
            }
            else if (userAnswer.equals("no"))
            {
                isIncorrect = false;
            }
            else
            {
                System.out.println("You input incorrect word! Try again.");
            }
        } while (isIncorrect);
        return false;
    }

    public static int inputSizeOfMatrixFromFile(BufferedReader reader) throws IOException
    {
        int n = 0;
        char currentChar = '\0';
        boolean wasNumber = false;
        boolean isCorrect = false; // for exit the loop
        String number = ""; // string for parse Number
        int character = 0;
        while(!isCorrect && (character = reader.read()) != -1)
        {
            currentChar = (char)(character);
            if ((Character.isDigit(currentChar)))
            {
                number += currentChar;
                wasNumber = true;
            }
            else if (wasNumber)
            {
                n = Integer.parseInt(number);
                isCorrect = true;
            }
            else if (currentChar != ' ' && currentChar != '\n' && currentChar != '\r')
            {
                throw new IOException();
            }
        }
        if (n < minMatrixOrder && wasNumber)
        {
            System.err.printf("Matrix order cannot be less than %d.\n", minMatrixOrder);
            n = 0;
        }
        return n;
    }

    public static double[][] inputElementsOfMatrixFromFile(BufferedReader reader, int n) throws IOException
    {
        boolean wasNumber = false;
        boolean isCorrect = false;
        double[][] matrix = null;
        char currentChar = '\0';
        String number = "";
        int character = 0;
        // initialization of matrix
        matrix = initialization(n);
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                isCorrect = false;
                wasNumber = false;
                number = "";
                while(!isCorrect && (character = reader.read()) != -1)
                {
                    currentChar = (char)(character);
                    if (Character.isAlphabetic(currentChar))
                    {
                        throw new IOException();
                    }
                    else if ((Character.isDigit(currentChar)) || currentChar == '.')
                    {
                        number += currentChar;
                        wasNumber = true;
                    }
                    else if (wasNumber)
                    {
                        matrix[i][j] = Double.parseDouble(number);
                        isCorrect = true;
                    }
                }
                if (!number.isEmpty())
                {
                    matrix[i][j] = Double.parseDouble(number);
                }

            }
        }
        return matrix;
    }

    public static double[][] input()
    {
        int n = 0; // size
        double[][] matrix = null;
        if (inputMethod())
        {
            // input size of matrix
            n = inputSizeOfMatrixFromConsole();
            // input elements of matrix
            matrix = inputElementsOfMatrixFromConsole(n);
        }
        else
        {
            boolean isNotExit = true;
            do
            {
                String fileName = inputReadFileName();
                try (BufferedReader reader = new BufferedReader(new FileReader(fileName)))
                {
                    // input size of matrix
                    n = inputSizeOfMatrixFromFile(reader);
                    // input elements of matrix
                    matrix = inputElementsOfMatrixFromFile(reader,n);
                }
                catch(IOException ex)
                {
                    System.err.println("Invalid type. Check data in the file.");
                    n = 0;
                }
                if (n != 0)
                {
                    isNotExit = false;
                }
                else if (!isAnotherFile())
                {
                    isNotExit = false;
                }
            } while(isNotExit);
        }
        return matrix;
    }

    public static boolean outputMethod()
    {
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
                return true;
            }
            else if (choice.equals("file"))
            {
                isIncorrect = false;
            }
            else // wrong input
                System.err.println("The word '" + choice + "' don't match any of method to output the data.");
        } while(isIncorrect);
        return false;
    }

    public static void outputConsole(final double answer)
    {
        System.out.printf("The answer is %6.3f.",answer);
    }

    public static void outputFile(final double answer)
    {
        String fileName = inputWriteFileName();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName)))
        {
            writer.write("The answer is " + answer + ".\n");
        }
        catch (IOException ex)
        {
            System.err.println("Something went wrong!!!");
        }
        System.out.println("Answer has been written down successful.");
    }

    public static void output(final double answer)
    {
        if (outputMethod())
        {
            outputConsole(answer);
        }
        else
        {
            outputFile(answer);
        }
    }

    public static double findSum(double[][] matrix)
    {
        double sum = 0.0;
        int i = 0;
        int j = 0;
        int step = matrix.length;
        int center = matrix.length / 2;
        for (; i < center; i++)
        {
            j = i;
            for (int k = 0; k < step; k++)
            {
                sum += matrix[i][j++];
            }
            step -= 2;
        }
        if (step == 0)
        {
            step += 2;
        }
        for (; i < matrix.length; i++)
        {
            j = matrix.length - i - 1;
            for (int k = 0; k < step; k++)
            {
                sum += matrix[i][j++];
            }
            step += 2;
        }
        return sum;
    }

    public static void main(String[] args)
    {
        double answer = 0.0;
        double[][] matrix = null;
        matrix = input();
        if (matrix != null)
        {
            answer = findSum(matrix);
            output(answer);
        }
        in.close();
    }
}