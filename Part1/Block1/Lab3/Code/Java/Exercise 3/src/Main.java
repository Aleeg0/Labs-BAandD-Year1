import java.util.Scanner;
import java.math.*;

public class Main {
    public static void main(String[] args) {
        //initialization
        boolean goodFlag = false, //for exit loop
                isFinding = false; // for task
        int counter = 0;
        double eps = 0.0,
                xLast = 0.0, // X0
                x = 0.0;
        Scanner in = new Scanner(System.in);
        //output the task
        System.out.print("""
                           Program solves this example: Ln(7.622x) - 8.59x + 5 = 0.
                           It's recommended to input epsilon, using standard form.
                           Example: 1e-9
                           Or using normal input.
                           Example: 0.1
                           """);
        // loop for check inputted eps
        do {
            try {
                //input
                System.out.println("Enter eps:");
                eps = Double.parseDouble(in.nextLine());
                if (eps > 0.1) {
                    System.err.println("Eps is too big!!! Try again.");
                }
                else if (eps < 1.0e-17) {
                    System.err.println("Eps is too little!!! Try again.");
                }
                else // to exit the loop if user entered correct epsilon
                    goodFlag = true;
            }
            catch (NumberFormatException ex) {
                System.err.println("Invalid type!!! Try again.");
            }
        } while(!goodFlag);
        // output some more info
        System.out.println("Enter x to start the calculation with:");
        // loop for check inputted X0
        goodFlag = false;
        do {
            try {
                System.out.println("Enter X0");
                xLast = Double.parseDouble(in.nextLine());
                if (xLast < 0 || xLast == 0) {
                    System.err.println("X0 cannot be less or equal than 0, because in the task there's logarithm!!! (7.622x > 0) Try again.");
                }
                else if ((double)(100)/((double)(859) * xLast) > 1) {
                    System.err.println("The problem is not solvable using the inputted X0!!! Try again.");
                }
                else // to exit the loop if user entered correct limits
                    goodFlag = true;
            }
            catch (NumberFormatException ex) {
                System.err.println("Invalid type!!! Try again.");
            }
        } while(!goodFlag);
        in.close();
        // main block
        //creating table
        System.out.printf("     %-5s|", "N");
        System.out.printf("    %-6s|", "X-1");
        System.out.println("    X");
        System.out.println("--------------------------------");
        while(!isFinding)
        {
            x = (Math.log(7.622 * xLast) + 5) / 8.59;
            System.out.printf("%-10s|", counter);
            System.out.printf("%f  |", xLast);
            System.out.printf("%f\n", x);
            if (Math.abs(x - xLast) < eps)
                isFinding = true;
            else
                xLast = x;
            counter += 1;
        }
        // output
        System.out.printf("\nThe answer of this task is %f.\n", x);
    }
}