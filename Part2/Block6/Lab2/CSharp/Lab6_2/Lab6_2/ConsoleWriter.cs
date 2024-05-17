using System.Drawing;

namespace Lab6_2;

public class ConsoleWriter
{
    public void Output(int[,] matrix,int size)
    {
        Console.WriteLine("Магический квадрат.");
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
                Console.Write(matrix[i,j] + " ");
            Console.WriteLine();
        }
        Console.WriteLine();
    }
}