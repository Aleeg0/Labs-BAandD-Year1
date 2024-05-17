namespace ConsoleApp1;

public class ConsoleReader
{
    public int InputSizeOfArr()
    {
        int size;
        bool isBad = true;
        do
        {
            Console.WriteLine("Введите размер массива: ");
            if (int.TryParse(Console.ReadLine(), out size))
                isBad = false;
            else
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
            if (!isBad && size < 1)
            {
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongBoundOfNumber]);
                isBad = true;
            }
        } while (isBad);
        return size;
    }

    public int[] InputElementsOfArr( int size)
    {
        int[] arr = new int[size];
        bool isBad = true;
        int number;
        for (int i = 0; i < size; i++)
        {
            isBad = true;
            do
            {
                Console.Write("Введите " + (i + 1) + " элемент: ");
                if (int.TryParse(Console.ReadLine(), out number))
                    isBad = false;
                else
                    Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
            } while (isBad);
            arr[i] = number;
        }
        return arr;
    }
}