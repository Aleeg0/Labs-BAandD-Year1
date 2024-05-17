namespace Lab5_2;

/// <summary>
/// Реализация бинарного дерева
/// </summary>
/// <typeparam name="T">int, double, extended, char</typeparam>
public class Tree<T> where T : IComparable<T>
{
    private class Root 
    {
        public T value { get; set; }
        public Root? right { get; set; }
        public Root? left { get; set; }
        public Root? perent { get; set; }

        public Root(T value)
        {
            this.value = value;
            right = null;
            left = null;
            perent = null;
        }
    }

    private Root tree;

    public Tree()
    {
        tree = null;
    }
    
    public void Add(T value)
    {
        if (tree == null)
            tree = new Root(value);
        else
        {
            Root cur = tree;
            bool isWriten = false;
            while (!isWriten)
            {
                if (cur.value.CompareTo(value) > 0)
                {
                    if (cur.left == null)
                    {
                        cur.left = new Root(value);
                        cur.left.perent = cur;
                        isWriten = true;
                    }
                    else
                    {
                        cur = cur.left;
                    }
                }
                else if (cur.value.CompareTo(value) < 0)
                {
                    if (cur.right == null)
                    {
                        cur.right = new Root(value);
                        cur.right.perent = cur;
                        isWriten = true;
                    }
                    else
                    {
                        cur = cur.right;
                    }
                }
                else
                {
                    isWriten = true;
                }
            }
        }
    }
    
    /// <summary>
    /// функция находит максимальную высоту дерева и список,
    /// в котором записаны значения веток, у которых
    /// высота левого поддерева не равно правому 
    /// </summary>
    /// <param name="temp">текущая ветка</param>
    /// <param name="list">список</param>
    /// <returns>максимальную высоту дерева</returns>
    private int FindValues(Root temp, List<T> list)
    {
        if (temp == null)
            return 0;
        int left = FindValues(temp.left!, list) + 1;
        int right = FindValues(temp.right!, list) + 1;
        if (left != right)
            list.Add(temp.value);
        return (left > right) ? left : right;
    }
    
    public List<T> FindValues()
    {
        List<T> list = new List<T>();
        FindValues(tree, list);
        return list;
    }
}