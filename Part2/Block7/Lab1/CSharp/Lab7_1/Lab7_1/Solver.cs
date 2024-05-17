namespace Lab7_1;

public static class Solver
{
    public static int[,] BuildMatrix(LinkedList<LinkedList<int>> linkedList, int size)
    {
        int[,] matrix = new int[size, size];
        int i = 0;
        foreach (var list in linkedList)
        {
            int[] arr = list.ToArray();
            int k = 0;
            for (int j = 0; j < size; j++)
            {
                if (k < arr.Length && arr[k] - 1 == j)
                {
                    matrix[i, j] = 1;
                    k++;
                }
                else
                    matrix[i, j] = 0;
            }

            i++;
        }
        return matrix;
    }
}