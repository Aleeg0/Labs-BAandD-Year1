import java.util.Scanner;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {
        //initialization
        final int SIDE = 3;
        int n = 0;
        double a = 0.0;
        double b = 0.0;
        double c = 0.0;
        double highestSquare = -1.0;
        double currentSquare = -1.0;
        double p = 0.0; // half-perimeter
        boolean isIncorrect = true;
        Scanner in = new Scanner(System.in);
        System.out.println("The program finding a triangle with the highest square.");
        // make sure that user enter correct size
        do
        {
            try {
                System.out.println("Enter how many triangles: ");
                n = Integer.parseInt(in.nextLine());
                if (n < 1)
                    System.err.println("Entering number cannot be less than 1!!! Try again.");
                else
                    isIncorrect = false;
            }
            catch (NumberFormatException ex)
            {
                System.err.println( "Invalid type!!! Try again.");
            }
        } while (isIncorrect);
        // input sides of triangles
        for (int i = 0; i < n; i++)
        {
            do {
                //inputting first side
                isIncorrect = true;
                do {
                    try {
                        System.out.println("Enter first side of triangle number " + (i + 1) + ": ");
                        a = Double.parseDouble(in.nextLine());
                        if (a < 0.0 || a == 0.0)
                            System.err.println("Entering number cannot be less than 0!!! Try again.");
                        else
                            isIncorrect = false;
                    }
                    catch (NumberFormatException ex)
                    {
                        System.err.println( "Invalid type!!! Try again.");
                    }
                }while (isIncorrect);
                //inputting second side
                isIncorrect = true;
                do {
                    try {
                        System.out.println("Enter second side of triangle number " + (i + 1) + ": ");
                        b = Double.parseDouble(in.nextLine());
                        if (b < 0.0 || b == 0.0)
                            System.err.println("Entering number cannot be less than 0!!! Try again.");
                        else
                            isIncorrect = false;
                    }
                    catch (NumberFormatException ex)
                    {
                        System.err.println( "Invalid type!!! Try again.");
                    }
                }while (isIncorrect);
                //inputting third side
                isIncorrect = true;
                do {
                    try {
                        System.out.println("Enter third side of triangle number " + (i + 1) + ": ");
                        c = Double.parseDouble(in.nextLine());
                        if (c < 0.0 || c == 0.0)
                            System.err.println("Entering number cannot be less than 0!!! Try again.");
                        else
                            isIncorrect = false;
                    }
                    catch (NumberFormatException ex)
                    {
                        System.err.println( "Invalid type!!! Try again.");
                    }
                }while (isIncorrect);
                // check the triangle for correctness
                if (a + b > c && a + c > b && b + c > a)
                    isIncorrect = false;
                else
                {
                    System.err.printf( "Triangle with sides %.3f %.3f %.3f doesn't exist\n",a,b,c);
                    isIncorrect = true;
                }
            }while (isIncorrect);
            p = (a + b + c) / 2.0;
            currentSquare = Math.sqrt(p * (p - a) * (p - b) * (p - c));
            if (currentSquare > highestSquare)
            {
                highestSquare = currentSquare;
            }
        }
        System.out.printf("The best triangle has square equal %.3f.\n",highestSquare);
    }
}