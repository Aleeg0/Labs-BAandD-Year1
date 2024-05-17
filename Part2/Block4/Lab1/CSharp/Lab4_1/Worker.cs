namespace Lab4_1;

public record Worker()
{
    public int WId { get; set; }
    public string? WSurname { get; set; }
    public string? WCompany { get; set; }
    public int WCountOfDetailsA { get; set; }
    public int WCountOfDetailsB { get; set; }
    public int WCountOfDetailsC { get; set; }
};