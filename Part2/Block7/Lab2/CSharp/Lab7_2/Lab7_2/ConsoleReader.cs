namespace Lab7_2;

public class ConsoleReader
{
    public int InputCountOfNodes()
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
    
    public int InputCountOfEdges()
    {
        int size;
        bool isBad = true;
        do
        {
            Console.WriteLine("Введите количество ребер: ");
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

    public int InputStartV()
    {
        int start;
        bool isBad = true;
        do
        {
            Console.WriteLine("Введите стартовую точку: ");
            if (int.TryParse(Console.ReadLine(), out start))
                isBad = false;
            else
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
            if (!isBad && start < 1)
            {
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongBoundOfNumber]);
                isBad = true;
            }
        } while (isBad);
        return start;
    }
    
    public int InputFinishV()
    {
        int finish;
        bool isBad = true;
        do
        {
            Console.WriteLine("Введите стартовую точку: ");
            if (int.TryParse(Console.ReadLine(), out finish))
                isBad = false;
            else
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
            if (!isBad && finish < 1)
            {
                Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongBoundOfNumber]);
                isBad = true;
            }
        } while (isBad);
        return finish;
    }
    
    public Edge[] InputElements(int size)
    {
        Edge[] edges = new Edge[size];
        bool isBad = true;
        int number;
        for (int i = 0; i < size; i++)
        {
            do
            {
                Console.WriteLine("Введите начальную вершину ребра:");
                if (int.TryParse(Console.ReadLine(), out number))
                    isBad = false;
                else
                    Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
                if (!isBad && number < 1)
                {
                    Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongBoundOfNumber]);
                    isBad = true;
                }
            } while (isBad);
            edges[i].a = number;
            do
            {
                Console.WriteLine("Введите конечную вершину ребра:");
                if (int.TryParse(Console.ReadLine(), out number))
                    isBad = false;
                else
                    Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
                if (!isBad && number < 1)
                {
                    Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongBoundOfNumber]);
                    isBad = true;
                }
            } while (isBad);
            edges[i].a = number;
            do
            {
                Console.WriteLine("Введите вес ребра:");
                if (int.TryParse(Console.ReadLine(), out number))
                    isBad = false;
                else
                    Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
                if (!isBad && (number < int.MinValue + 1 || int.MaxValue - 1 < number))
                {
                    Console.WriteLine(MainMenu.ErrorMessagesArr[(int)ErrorMessages.EmWrongBoundOfNumber]);
                    isBad = true;
                }
            } while (isBad);
            edges[i].a = number;
        }
        return edges;
    }
}