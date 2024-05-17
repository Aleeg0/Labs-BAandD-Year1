namespace Lab7_2;

public static class Solver
{
    public static int[] FindPath(int countOfNodes, Edge[] edges,int start,int finish)
    {
        const int INF = Int32.MaxValue;
        int[] from = new int[countOfNodes];
        Array.Fill(from,-1);
        int[] dist = new int[countOfNodes];
        Array.Fill(dist,INF);
        dist[start] = 0;
        int count = countOfNodes - 1;
        for (int i = 0; i < count; i++)
        {
            foreach (var (a,b,weight) in edges)
            {
                if (dist[a] != INF && dist[b] > dist[a] + weight)
                {
                    dist[b] = dist[a] + weight;
                    from[b] = a;
                }
            }    
        }

        List<int> path = new List<int>(); 
        for (int v = finish; v != -1; v = from[v])
            path.Add(v);
        path.Reverse();
        return path.ToArray();
    }
        
}