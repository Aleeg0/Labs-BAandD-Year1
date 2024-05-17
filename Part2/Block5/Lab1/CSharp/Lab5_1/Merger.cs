namespace Lab5_1;

public class Merger
{
    public List<int> MergeTwoLists(List<int> list1,List<int> list2)
    {
        List<int> list3 = new List<int>();
        int leftPtr = 0;
        int rightPtr = 0;
        while (leftPtr < list1.Count || rightPtr < list2.Count)
        {
            if (leftPtr > list1.Count - 1)
                while (rightPtr < list2.Count)
                    list3.Add( list2[rightPtr++]); 
            else if (rightPtr > list2.Count - 1)
                while (leftPtr < list1.Count)
                    list3.Add(list1[leftPtr++]);
            else if (list1[leftPtr] < list2[rightPtr])
                list3.Add(list1[leftPtr++]);
            else
                list3.Add(list2[rightPtr++]);
        }
        return list3;
    }

    public bool IsListDecreasing(List<int> list)
    {
        bool isDecreasing = false;
        for (int i = 0; i < list.Count; i++)
            if (!isDecreasing && i > 0 && list[i - 1] > list[i])
                isDecreasing = true;
        return isDecreasing;
    }
}