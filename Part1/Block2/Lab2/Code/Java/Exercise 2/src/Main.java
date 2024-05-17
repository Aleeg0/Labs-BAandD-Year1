import java.util.Scanner;


public class Main {
    static final int maxK = 10000000;
    static final int minK = 1;
    static final int maxDigit = 9;
    static final int maxDigits = 10;
    public static int input(int k) {
        boolean isIncorrect = true;
        boolean isNumber = false;
        Scanner in = new Scanner(System.in);
        System.out.println("The program finds all natural numbers that are k times greater than the sum of their digits.");
        do {
            isNumber = false;
            try {
                k = Integer.parseInt(in.nextLine());
                isNumber = true;
            }
            catch (NumberFormatException exception)
            {
                System.err.println("Invalid type! Try again.");
            }
            if (isNumber && k < minK)
                System.err.printf("The entered number cannot be less than %d! Try again.\n",minK);
            else if (isNumber && k > maxK )
                System.err.printf("The entered number cannot be more than %d! Try again.\n",maxK);
            else if (isNumber)
                isIncorrect = false;
        } while(isIncorrect);
        return k;
    }
    public static void output(int naturalNumber)
    {
        System.out.print(naturalNumber + " ");
    }

    public static int digitsSum(int naturalNumber)
    {
        int sum = 0;
        while (naturalNumber != 0)
        {
            sum += naturalNumber % 10;
            naturalNumber /= 10;
        }
        return sum;
    }

    public static int findMaxNumber(int k)
    {
        int maxNumber = 1;
        int countOfDigits = 1;
        while (countOfDigits < maxDigits && k * maxDigit * countOfDigits++ >= maxNumber)
        {
            maxNumber *= 10;
        };
        return maxNumber /= 10;
    }

    public static void findNumbers(int k)
    {
        int naturalNumber = k;
        int maxNumber = findMaxNumber(k);
        while (naturalNumber < maxNumber)
        {
            if (naturalNumber == digitsSum(naturalNumber) * k)
                output(naturalNumber);
            naturalNumber += k;
        }
    }

    public static void main(String[] args) {
        int k = 0;
        k = input(k);
        findNumbers(k);
    }
}