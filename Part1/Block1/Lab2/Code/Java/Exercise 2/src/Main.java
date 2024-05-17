import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // initialization
        int n = 0, sum = 0, high = 0, number = 1;
        boolean goodFlag = false;
        Scanner in = new Scanner(System.in);
        // output the task
        System.out.println("Calculate the sum using the formula (-1)^i * 2^i.\n");
        // loop for check inputted symbols
        do {
            try {
                //input
                System.out.println("Enter n:");
                n = Integer.parseInt(in.nextLine());
                //check if input is wrong or less than 0
                if (n < 1) {
                    System.err.println("n cannot be less than 1!!!");
                }
                else // to exit the loop if user entered correct symbols
                    goodFlag = true;
            }
            catch (NumberFormatException ex)
            {
                System.err.println("Invalid type!!! Try again.");
            }
        } while(!goodFlag);
        in.close();
        //main block
        high = n + 1;
        for (int i = 1; i < high; i++)
        {
            number *= 2;
            if (i % 2 != 0)
                sum -= number;
            else
                sum += number;
        }
        //output
        System.out.println("Sum equal " + sum);
        System.out.println();
    }
}