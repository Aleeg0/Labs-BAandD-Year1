namespace Lab6_2;

public class MainMenu
{

    public static readonly String[] ErrorMessagesArr =
    {
        "Выбран не существующий пункт! Повторите еще раз.",
        "Не верный тип данных! Повторите ещё раз.",
        "Число не может быть меньше 1! Повторите ещё раз.",
        "Вы ввели четное число! Повторите ещё раз."
    };

    private static readonly String[] FileStatusMessages =
    {
        "Операция прошла успешно!",
        "Файл не найден! Повторите ещё раз.",
        "Файл не текстовый! Повторите ещё раз.",
        "Файл закрыт для чтения! Повторите ещё раз.",
        "Файл закрыт для записи! Повторите ещё раз.",
        "Файл пустой. Повторите ещё раз.",
        "Информация в файле неправильная! Повторите ещё раз.",
        "Количество элементов не совпадает с указанным размером массива! Потворите еще раз.",
        "Упс... Что-то пошло не так!"
    };

    public void ShowProgramInfo()
    {
        Console.WriteLine("Программа строит магический квадрат нечётной степени.");
    }

    public int InputChoice()
    {
        int choose = 0;
        bool isBad = true;
        do
        {
            Console.Write("Ваш выбор: ");
            if (int.TryParse(Console.ReadLine(), out choose))
                isBad = false;
            else
                Console.WriteLine(ErrorMessagesArr[(int)ErrorMessages.EmWrongType]);
        } while (isBad);

        return choose;

    }

    public void ShowWrongKeyMessage()
    {
        Console.WriteLine(ErrorMessagesArr[(int)ErrorMessages.EmWrongKey]);
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

    public void InputShowMenu()
    {
        Console.WriteLine("Меню ввода:\n" +
                          "1. Ввести размер с консоли;\n" +
                          "2. Выгрузить размер из файла.");
    }

    public void OutputShowMenu()
    {
        Console.WriteLine("Меню вывода:\n" +
                          "1. Вывести магический квадрат в консоль;\n" +
                          "2. Записать магический квадрат в файл.");
    }
}
