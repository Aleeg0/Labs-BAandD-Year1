using System.Drawing;

namespace ConsoleApp1;

public class ConsoleWriter
{
    public void Output(int[] arr)
    {
        Console.WriteLine("Отсортированный массив:");
        for (int i = 0; i < arr.Length; i++)
        {
            Console.Write(arr[i] + " ");
        }
        Console.WriteLine();
    }
}