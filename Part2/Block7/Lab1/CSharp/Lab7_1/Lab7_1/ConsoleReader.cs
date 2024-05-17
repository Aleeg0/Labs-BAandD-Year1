namespace Lab7_1;

public class ConsoleReader
{
    public int InputSizeOfNodes()
    {
        int size;
        bool isBad = true;
        do
        {
            Console.WriteLine("Введите количество вершин: ");
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

    public LinkedList<LinkedList<int>> InputElements(int size)
    {
        LinkedList<LinkedList<int>> allNodes = new LinkedList<LinkedList<int>>();
        bool isBad = true;
        int number;
        for (int i = 0; i < size; i++)
        {
            LinkedList<int> nodes = new LinkedList<int>();
            do
            {
                number = -2;
                isBad = true;
                do
                {
                    Console.Write("Введите номер вершины с которой связана " + (i + 1) + " вершина графа,\n (для того, чтобы закончить ввод введите -1): ");
                    if (int.TryParse(Console.ReadLine(), out number))
                        isBad = false;
                    else
                        Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
                    if (!isBad)
                    {
                        if (number < -1 || size < number)
                        {
                            isBad = false;
                            Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongBoundOfNumber]);
                        }
                        else if (number != -1)
                            nodes.AddLast(number);
                    }
                } while (isBad);
                
            } while (number != -1);
            allNodes.AddLast(nodes);
        }
        return allNodes;
    }
}