namespace Lab5_1;

public class ConsoleReader
{
    public int InputSizeOfList()
    {
        int size;
        bool isBad = true;
        do
        {
            Console.WriteLine("Введите размер списка: ");
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

    public List<int> InputElementsOfList( int size)
    {
        List<int> list = new List<int>();
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
            list.Add(number);
        }
        return list;
    }
}