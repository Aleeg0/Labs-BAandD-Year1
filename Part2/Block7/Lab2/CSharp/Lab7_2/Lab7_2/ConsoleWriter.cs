using System.Drawing;

namespace Lab7_2;

public class ConsoleWriter
{
    public void Output(int[] path)
    {
        Console.WriteLine("Кратчайший путь:");
        for (int i = 0; i < path.Length - 1; i++)
        {
            Console.Write(path[i] + "->");    
        }
        Console.WriteLine(path[^1]);
    }
}