namespace ConsoleApp1;

public class Sorter
{
    private protected int Partition(int[] arr, int start, int end)
    {
        int pivot = arr[end];
        int i = start - 1;
        for (int j = start; j < end; j++)
        {
            if (arr[j] < pivot)
            {
                i++;
                (arr[i], arr[j]) = (arr[j], arr[i]);
            
            }
        }

        i++;
        (arr[i], arr[end]) = (arr[end], arr[i]);
        return i;
    }

    public void QuickSort(ref int[] arr, int start, int end)
    {
        if (end <= start) return;
        int pivot = Partition(arr, start, end);
        QuickSort(ref arr,start,pivot - 1);
        QuickSort(ref arr,pivot + 1,end);
    }

}