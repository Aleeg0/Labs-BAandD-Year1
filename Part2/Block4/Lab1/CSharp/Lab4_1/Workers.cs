namespace Lab4_1;

public class Workers
{
    private List<Worker> listOfWorkers = new List<Worker>();

    public Worker this[int i]
    {
        get => listOfWorkers[i];
        set => listOfWorkers[i] = value;
    }

    public int Count => listOfWorkers.Count;

    public void ChangeWorker(int id, Worker worker)
    {
        worker.WId = id - 1;
        listOfWorkers[id - 1] = worker;
    }

    public void AddWorker(Worker worker)
    {
        worker.WId = listOfWorkers.Count;
        listOfWorkers.Add(worker);
    }

    public void DeleteWorker(int id)
    {
        Worker worker;
        listOfWorkers.Remove(listOfWorkers[id - 1]);
        // move all indexes after we were removed worker with id
        for (int i = id; i < listOfWorkers.Count; i++)
        {
            listOfWorkers[i].WId = i + 1;
        }
    }

}