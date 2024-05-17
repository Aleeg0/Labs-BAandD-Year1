namespace Lab5_2;

public class ConsoleReader
{
    public int InputSizeOfTree()
    {
        int size;
        bool isBad = true;
        do
        {
            Console.WriteLine("Введите количество элементов в дереве: ");
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

    public Tree<int> InputElementsOfTree(int size)
    {
        Tree<int> tree = new Tree<int>();
        bool isBad = true;
        int number;
        for (int i = 0; i < size; i++)
        {
            isBad = true;
            do
            {
                Console.Write("Введите " + (i + 1) + " элемент дерева: ");
                if (int.TryParse(Console.ReadLine(), out number))
                    isBad = false;
                else
                    Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
            } while (isBad);
            tree.Add(number);
        }
        return tree;
    }
}