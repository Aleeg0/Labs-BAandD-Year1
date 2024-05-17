using Lab4_1;
using Microsoft.VisualBasic;

public class MainMenu
{
    private static readonly string[] ErrorMessagesArr = {
        "Не верный тип данных! Повторите ещё раз.",
        "Число не может быть меньше 1! Повторите ещё раз.",
        "Работника с введённым индексом не существует! Повторите ещё раз.",
        "Выбран не существующий пункт! Повторите ещё раз.",
        "Таблица пуста!",
        "Компания не найдена! Повторите ещё раз."
    };
    
    private static readonly string[] FileStatusMessages = {
        "Операция прошла успешно!",
        "Файл не найден! Повторите ещё раз.",
        "Файл не текстовый! Повторите ещё раз.",
        "Файл закрыт для чтения! Повторите ещё раз.",
        "Файл закрыт для записи! Повторите ещё раз.",
        "Упс... Что-то пошло не так!"
    };

    public void ShowMainMenu()
    {
        Console.WriteLine(
            "Меню:\n" +
            "1. Посмотреть таблицу\n" +
            "2. Выгрузить таблицу\n" +
            "3. Сохранить таблицу\n" +
            "4. Сохранить доп. информацию\n" +
            "5. Выйти"
        );
    }

    public void ShowProgramInfo()
    {
        Console.WriteLine("Программа для записи данных о рабочих.");
    }

    public void ShowProgramExitMessage()
    {
        Console.WriteLine("Выход...");  
    }
        
    public void ShowErrorEmptyMessage()
    {
        Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmEmptyTable]);
    }
    
    public void ShowErrorKeyMessage()
    {
        Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongKey]);
    }
    public void ShowTable(Workers workers)
    {
        Console.WriteLine("\t\t\tТаблица рабочих");
        Console.WriteLine(" ID |  Фамилия  | Название Цеха |Детали A(Кол.) |Детали B(Кол.) |Детали C(Кол.)");
        Console.WriteLine("-------------------------------------------------------------------------------");
        for (int i = 0; i < workers.Count; i++)
        {
            Worker worker = workers[i];
            Console.WriteLine($"{worker.WId+1:0000}|{worker.WSurname}\t|{worker.WCompany}\t\t|{worker.WCountOfDetailsA}\t\t|{worker.WCountOfDetailsB}\t\t|{worker.WCountOfDetailsC}");
        }
        Console.WriteLine();
    }   

    public int InputId(int countOfWorkers)
    {
        bool isBad = true;
        int id = 0;
        Console.WriteLine("Введите id работника, которого хотите изменить:");
        do
        {
            try
            {
                id = Convert.ToInt32(Console.ReadLine());
                isBad = false;
            }
            catch(FormatException e)
            {
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongType]);
            }
            if (!isBad && (id < 1 || countOfWorkers < id))
            {
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongWorkerId]);
                isBad = true;
            }
        } while (isBad);
        return id;
    }

    public Worker InputWorker()
    {
        Worker worker = new Worker();
        bool isBad = true;
        int tempInputNumber = 0;
        Console.WriteLine("Введите фамилию:");
        worker.WSurname = Console.ReadLine();
        Console.WriteLine("Введите компанию:");
        worker.WCompany = Console.ReadLine();
        Console.WriteLine("Введите количество деталей A:");
        do
        {
            try
            {
                tempInputNumber = Convert.ToInt32(Console.ReadLine());
                isBad = false;
            }
            catch(FormatException e)
            {
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongType]);
            }
            if (!isBad && tempInputNumber < 1)
            {
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongBoundOfNumber]);
                isBad = true;
            }

        } while (isBad);
        worker.WCountOfDetailsA = tempInputNumber;
        Console.WriteLine("Введите количество деталей B:");
        isBad = true;
        do
        {
            try
            {
                tempInputNumber = Convert.ToInt32(Console.ReadLine());
                isBad = false;
            }
            catch(FormatException e)
            {
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongType]);
            }
            if (!isBad && tempInputNumber < 1)
            {
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongBoundOfNumber]);
                isBad = true;
            }

        } while (isBad);
        worker.WCountOfDetailsB = tempInputNumber;
        Console.WriteLine("Введите количество деталей C:");
        isBad = true;
        do
        {
            try
            {
                tempInputNumber = Convert.ToInt32(Console.ReadLine());
                isBad = false;
            }
            catch(FormatException e)
            {
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongType]);
            }
            if (!isBad && tempInputNumber < 1)
            {
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongBoundOfNumber]);
                isBad = true;
            }

        } while (isBad);
        worker.WCountOfDetailsC = tempInputNumber;
        return worker;
    }

    public void ShowTableMenu()
    {
        Console.WriteLine(
            "Меню таблиц:\n" +
            "1. Добавить рабочего\n" +
            "2. Удалить рабочего\n" +
            "3. Изменить рабочего\n" +
            "4. Выйти в главное меню\n"
        );    
    }

    public string? InputFilePath()
    {
        Console.WriteLine("Введите путь к файлу:");
        return Console.ReadLine();
    }

    public void ShowFileStatusMessage(FileStatus fileStatus)
    {
        Console.WriteLine(FileStatusMessages[(int)fileStatus]);
    }

    public int[] InputPrices()
    {
        const int COUNT_OF_DETAILS = 3;
        int[] prices = new int[COUNT_OF_DETAILS];
        int tempInputNumber;
        bool isBad = true;
        Console.WriteLine("Введите расценки для деталей.");
        do
        {
            Console.WriteLine("Введите расценку детали А:");
            if (int.TryParse(Console.ReadLine(), out tempInputNumber))
            {
                if (tempInputNumber > 0)
                {
                    prices[0] = tempInputNumber;
                    isBad = false;
                }
                else
                    Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongBoundOfNumber]);
            }
            else
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongType]);
        } while (isBad);
        isBad = true;
        do
        {
            Console.WriteLine("Введите расценку детали B:");
            if (int.TryParse(Console.ReadLine(), out tempInputNumber))
            {
                if (tempInputNumber > 0)
                {
                    prices[1] = tempInputNumber;
                    isBad = false;
                }
                else
                    Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongBoundOfNumber]);
            }
            else
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongType]);
        } while (isBad);
        isBad = true;
        do
        {
            Console.WriteLine("Введите расценку детали C:");
            if (int.TryParse(Console.ReadLine(), out tempInputNumber))
            {
                if (tempInputNumber > 0)
                {
                    prices[2] = tempInputNumber;
                    isBad = false;
                }
                else
                    Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongBoundOfNumber]);
            }
            else
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongType]);
        } while (isBad);
        return prices;
    }

    public String? InputCompany(Workers workers)
    {
        String? company = null;
        Worker worker;
        bool isNotFound = true;
        do
        {
            Console.WriteLine("Введите название компании:");
            company = Console.ReadLine();
            for (int i = 0; i < workers.Count; i++)
            {
                worker = workers[i];
                if (isNotFound && company.Equals(worker.WCompany))
                    isNotFound = false;
            }
            if (isNotFound)
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmCompanyNotFound]);
        } while (isNotFound);
        return company;
    }

    public int InputChoose()
    {
        int choose = 0;
        bool isBad = true;
        do
        {
            Console.Write("Ваш выбор: ");
            if (int.TryParse(Console.ReadLine(), out choose))
                isBad = false;
            else
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMesagges.EmWrongType]);
        } while (isBad);
        return choose;
    }

    public void LoadDataMessage()
    {
        Console.WriteLine("Считывание данных...");
    }

    public void ShowTableMenuExitMessage()
    {
        Console.WriteLine("Выход в главное меню...");
    }
}