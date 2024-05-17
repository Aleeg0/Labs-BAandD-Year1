#include <iostream>
#include <string>
#include <fstream>
#include <set>



const std::set<char> KEY_SYMBOLS = { '[',']','{','}','(',')','+','-','*','/','%' };


class Reader
{
public:
    virtual std::string inputString() = 0;
    void emptyStringMessage();
protected:

};

void Reader::emptyStringMessage()
{
    std::cout << "Your string Empty! Try again.\n";
}

class ConsoleReader : public Reader
{
public:
    std::string inputString() override;
private:

};

std::string ConsoleReader::inputString()
{
    std::string inputtedString = "\0";
    bool isInCorrect = true;
    do
    {
        std::cout << "Enter string:\n";
        std::cin >> inputtedString;
        if (inputtedString != "\0")
            isInCorrect = false;
        else
            emptyStringMessage();
    } while (isInCorrect);
    return inputtedString;
}



class File
{
public:
    File(std::string fileName, size_t fileCode) : fileName(fileName), fileCode(fileCode)
    {
        if (fileCode == 0)
            fileStream = new std::fstream(fileName, std::ios::in);
        else
            fileStream = new std::fstream(fileName);
    }
    ~File() {
        delete fileStream;
    };
    bool isFileExist();
    bool isFileText();
    bool isFileWorking();
    bool isNotEmpty();
    bool isGood();
    std::string getString();
    void printSet(const std::set<char>&);
private:
    // code info
    // 0 - file for reading
    // 1 - file for writting
    // 2 - file for reading and writting
    //
    size_t fileCode;
    std::string fileName;
    std::fstream* fileStream;
    bool status = false;
};

bool File::isFileExist()
{
    if (fileStream->is_open())
    {
        fileStream->close();
        status = true;
    }
    else
    {
        status = false;
        std::cerr << "This file or the path to the file is specified incorrectly or does not exist! Try again.\n";
    }
    return status;
}

bool File::isNotEmpty()
{
    fileStream->open(fileName, std::ios::in);
    if (fileStream->peek() != std::fstream::traits_type::eof())
    {
        status = true;
    }
    else
    {
        status = false;
        std::cerr << "This file empty! Try again.\n";
    }
    fileStream->close();
    return status;
}

bool File::isFileText()
{
    std::string type = fileName.substr(fileName.length() - (size_t)(4));
    if (type == ".txt")
        status = true;
    else
    {
        status = false;
        std::cerr << "This file or path to the file isn't .txt! Try again.\n";
    }
    return status;
}


// if we can read(write) from(to) this file
bool File::isFileWorking()
{

    fileStream->open(fileName);
    if (fileStream->good())
    {
        status = true;
    }
    else
    {
        status = false;
        switch (fileCode)
        {
        case((size_t)0):
            std::cerr << "The program can't read from this file! Try again.\n";
            break;
        case((size_t)1):
            std::cerr << "The program can't write down this file! Try again.\n";
            break;
        default:
            std::cerr << "The program can't write down or read from this file! Try again.\n";
            break;
        }
    }
    fileStream->close();
    return status;

}


bool File::isGood()
{
    if (this->isFileExist() && this->isFileText() && this->isFileWorking())
    {
        if (fileCode == 0 && this->isNotEmpty())
        { }
    }
    return status;
}


std::string File::getString()
{
    fileStream->open(fileName);
    std::string inputtedString = "";
    *fileStream >> inputtedString;
    fileStream->close();
    return inputtedString;
}

void File::printSet(const std::set<char>& set)
{
    fileStream->open(fileName);
    if (set.size() != (size_t)0)
    {
        *fileStream << "Function found this symbols in the string.\n";
        for (auto& symbol : set)
        {
            *fileStream << symbol << " ";
        }
        *fileStream << std::endl;
    }
    else
        *fileStream << "Function didn't find symbols in string.\n";
    fileStream->close();
    std::cout << "Answer has been wrote successfully.\n";
}


class FileReader : public Reader
{
public:
    std::string inputString() override;
private:
    std::string fileName;
    size_t fileCode = (size_t)0; // check info about code in class File
};

std::string FileReader::inputString()
{
    File* in = nullptr;
    std::string inputtedString;
    do
    {
        delete in;
        std::cout << "Enter the name of file in this directory or path to this file including name of file:\n";
        std::cin >> fileName;
        in = new File(fileName, fileCode);
    } while (!in->isGood());
    inputtedString = in->getString();
    delete in;
    return inputtedString;
}


class Writer
{
public:
    virtual void outputSet(std::set<char>&) = 0;
protected:

};

class ConsoleWriter : public Writer
{
public:
    void outputSet(std::set<char>&) override;
private:

};

void ConsoleWriter::outputSet(std::set<char>& set)
{
    if (set.size() != (size_t)0)
    {
        std::cout << "Function found this symbols in the string.\n";
        for (auto& symbol : set)
        {
            std::cout << symbol << " ";
        }
        std::cout << std::endl;
    }
    else
        std::cout << "Function didn't find symbols in string.\n";
}


class FileWriter : public Writer
{
public:
    FileWriter() : fileCode((size_t)1)
    { };
    void outputSet(std::set<char>&) override;
private:
    std::string fileName;
    size_t fileCode = (size_t)1; // check info about code in class File
};

void FileWriter::outputSet(std::set<char>& set)
{
    File* out = nullptr;
    do
    {
        delete out;
        std::cout << "Enter the name of file in this directory or path to this file including name of file:\n";
        std::cin >> fileName;
        out = new File(fileName, fileCode);
    } while (!out->isGood());
    out->printSet(set);
    delete out;
}

void inputTask()
{
    std::cout << "This program finding the symbols in the string, which you'll input.\n"
              << "Symbols: ";
    for (auto& keySymbols : KEY_SYMBOLS)
    {
        std::cout << keySymbols << " ";
    }
    std::cout << "\nAnd digits that divided without remainder by 2." << std::endl;
}

int findSum()
{
    int sum = 10;
    return sum;
    return 8;
}


Reader* inputMethod()
{
    bool isIncorrect = true;
    Reader* reader = nullptr;
    std::string choice = "\0";
    // asking what the type user want to use
    std::cout << "The program works with console input or files.\n";
    do
    {
        std::cout << "To use console enter 'console'.\n"
            << "To use a file enter 'file'.\n"
            << "Enter what type you want to use: \n";
        std::cin >> choice;
        if (choice == "console")
        {
            reader = new ConsoleReader();
            isIncorrect = false;
        }
        else if (choice == "file")
        {
            reader = new FileReader();
            isIncorrect = false;
        }
        else // wrong input
            std::cerr << "The word '" << choice << "' don't match any of method to input the data.\n";
    } while (isIncorrect);
    return reader;
}

Writer* outputMethod()
{
    bool isIncorrect = true;
    std::string choice = "\0";
    Writer* writter = nullptr;
    // asking what the type user want to use
    std::cout << "The program is ready to show answer.\n";
    do
    {
        std::cout << "To output in console enter 'console'.\n"
            << "To output in a file enter 'file'.\n"
            << "Enter what type you want to use:\n";
        std::cin >> choice;
        if (choice == "console")
        {
            writter = new ConsoleWriter();
            isIncorrect = false;
        }
        else if (choice == "file")
        {
            writter = new FileWriter();
            isIncorrect = false;
        }
        else // wrong input
            std::cerr << "The word '" << choice << "' don't match any of method to output the data.\n";
    } while (isIncorrect);
    return writter;
}

std::set<char> findSymbols(std::string s)
{
    std::set<char> answer = {};
    for (size_t i = (size_t)0; i < s.length(); i++)
    {
        if (KEY_SYMBOLS.find(s[i]) != KEY_SYMBOLS.end() || (std::isdigit(s[i]) && ((int)(s[i] - '0') % 2 == 0)))
            answer.insert(s[i]);
    }
    return answer;
}

int main()
{
    // inputing info about Task 
    inputTask();
    Reader* reader = inputMethod();
    std::set<char> answer = findSymbols(reader->inputString());
    Writer* writer = outputMethod();
    writer->outputSet(answer);
    delete reader;
    delete writer;
    return 0;
}