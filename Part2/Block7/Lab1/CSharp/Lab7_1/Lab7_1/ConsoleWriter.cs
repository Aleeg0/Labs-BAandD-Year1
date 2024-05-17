using System.Drawing;

namespace Lab7_1;

public class ConsoleWriter
{
    public void Output(int[,] matrix,int size)
    {
        Console.WriteLine("Матрица смежности:");
        
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                Console.Write(matrix[i,j] + " ");
            }
            Console.WriteLine();
        }
        Console.WriteLine();
    }
}