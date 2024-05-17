import java.util.Scanner;


public class Main {
    public static void main(String[] args) {
        //initialization
        int n = 0;
        int[] list1 = null;
        boolean goodFlag = false;
        //output the task
        System.out.println("Program  outputs a new array, by using data entered" +
                           " array, according to this formula b[k]=2 * a[k]+k.");
        Scanner in = new Scanner(System.in);
        // loop for check inputted size
        do {
            try
            {
                //input
                System.out.println("Enter size of array:");
                n = Integer.parseInt(in.nextLine());
                //check if input is wrong or less than 1
                if (n < 1)
                {
                    System.out.print("N cannot be less than 1!!!");
                    throw new Exception();
                }
                goodFlag = true; // to exit the loop if user entered correct numbers
            }
            catch (Exception ex)
            {
                if (ex.getMessage() != null)
                    System.out.print("Invalid type!!!");
                System.out.println(" Try again.");
            }
        } while(!goodFlag);
        // memory allocation of the first array
        list1 = new int[n];
        // output more info
        System.out.println("Enter numbers, which you want to add in array:");
        // loop for check inputted numbers in array
        goodFlag = false;
        do {
            try
            {
                for (int i = 0; i < n; i++)
                {
                    System.out.println("Enter " + (i+1) + " number: ");
                    int number = Integer.parseInt(in.nextLine());
                    list1[i] = number;
                }
                goodFlag = true; // to exit the loop if user entered correct numbers
            }
            catch (Exception ex)
            {
                System.out.println("Invalid type!!! Try again.");
            }
        }while(!goodFlag);
        //closing the input
        in.close();
        //main block
        int[] list2 = new int[n];
        for (int i = 0; i < n; i++)
        {
            list2[i] = list1[i] * 2 + i + 1;
        }
        //output
        for (int i = 0; i < n; i++)
        {
            System.out.printf("Number %d in array: %d\n",i+1,list2[i]);
        }
    }
}