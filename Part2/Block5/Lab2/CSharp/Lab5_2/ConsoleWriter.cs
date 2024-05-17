using System.Drawing;

namespace Lab5_2;

public class ConsoleWriter
{
    public void Output(List<int> list)
    {
        Console.WriteLine("Значения вершин, укоторых высота левого поддерева не равна высоте правого поддерева:");
        for (int i = 0; i < list.Count; i++)
        {
            Console.Write(list[i] + " ");
        }
        Console.WriteLine();
    }
}