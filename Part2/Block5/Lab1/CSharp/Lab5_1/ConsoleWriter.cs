using System.Drawing;

namespace Lab5_1;

public class ConsoleWriter
{
    public void Output(List<int> list)
    {
        Console.WriteLine("Слитый воедино список:");
        for (int i = 0; i < list.Count; i++)
        {
            Console.Write(list[i] + " ");
        }
        Console.WriteLine();
    }
}