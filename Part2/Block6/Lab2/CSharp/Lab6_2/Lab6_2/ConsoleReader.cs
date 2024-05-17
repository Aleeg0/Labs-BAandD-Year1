namespace Lab6_2;

public class ConsoleReader
{
    public int InputSizeOfSquare()
    {
        const int MAX_SIZE = 9;
        const int MIN_SIZE = 3;
        int size;
        bool isBad = true;
        do
        {
            Console.WriteLine("Введите нечетное число от 3 до 9: ");
            if (int.TryParse(Console.ReadLine(), out size))
                isBad = false;
            else
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
            if (!isBad && (size < MIN_SIZE || MAX_SIZE < size))
            {
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongBoundOfNumber]);
                isBad = true;
            }
            if (!isBad && size % 2 == 0)
            {
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmIsEven]);
                isBad = true;
            }
        } while (isBad);
        return size;
    }
}