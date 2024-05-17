namespace Lab7_2;

public struct Edge
{
    public int a;
    public int b;
    public int weight;

    public void Deconstruct(out int a, out int b, out int weight)
    {
        a = this.a;
        b = this.b;
        weight = this.weight;
    }
}