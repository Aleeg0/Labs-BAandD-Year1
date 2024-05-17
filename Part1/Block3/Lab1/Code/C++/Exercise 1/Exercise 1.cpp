#include<iostream>
#include<string>
#include<fstream>



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
    ~File() 
    {  
        delete fileStream; 
    };
    bool isFileExist();
    bool isFileText();
    bool isFileWorking();
    bool isNotEmpty();
    bool isGood();
    std::string getString();
    void printString(const std::string);
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
        return true;
    }
    else
        std::cerr << "This file or the path to the file is specified incorrectly or does not exist! Try again.\n";
    return false;
}

bool File::isNotEmpty()
{
    fileStream->open(fileName, std::ios::in);
    if (fileStream->peek() != std::fstream::traits_type::eof())
    {
        fileStream->close();
        return true;
    }
    else
        std::cerr << "This file empty! Try again.\n";
    fileStream->close();
    return false;
}

bool File::isFileText()
{
    std::string type = fileName.substr(fileName.length() - (size_t)(4));
    if (type == ".txt")
        return true;
    else
        std::cerr << "This file or path to the file isn't .txt! Try again.\n";
    return false;
}


// if we can read(write) from(to) this file
bool File::isFileWorking()
{ 
    
    fileStream->open(fileName);
    if (fileStream->good()) 
    {
        fileStream->close();
        return true;
    }
    else if (fileCode == 0)
        std::cerr << "The program can't read from this file! Try again.\n";
    else if (fileCode == 1)
        std::cerr << "The program can't write down this file! Try again.\n";
    else
        std::cerr << "The program can't write down or read from this file! Try again.\n";
    fileStream->close();
    return false;
    
}


bool File::isGood()
{
    if (fileCode == 0 && this->isFileExist() && this->isFileText()
        && this->isFileWorking() && this->isNotEmpty())
        status = true;
    else if (fileCode > 0 && this->isFileExist() && this->isFileText()
        && this->isFileWorking())
        status = true;
    else
        status = false;
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

void File::printString(const std::string str)
{
    fileStream->open(fileName);
    if (str == "\0")
        *fileStream << "Function didn't find number in string.\n";
    else
        *fileStream << "The number in the string is " << str << std::endl;
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
    virtual void outputString(std::string) = 0;
protected:
        
};

class ConsoleWriter : public Writer
{
public:
    void outputString(std::string) override;
private:
        
};

void ConsoleWriter::outputString(std::string str)
{
    if (str == "\0")
        std::cout << "Function didn't find number in string.\n";
    else
        std::cout << "The number in the string is " << str << std::endl;
}



class FileWriter : public Writer
{
public:
    FileWriter() : fileCode((size_t)1)
    { };
    void outputString(std::string) override;
private:
    std::string fileName;
    size_t fileCode = (size_t)1; // check info about code in class File
};

void FileWriter::outputString(std::string str)
{
    File* out = nullptr;
    do
    {
        delete out;
        std::cout << "Enter the name of file in this directory or path to this file including name of file:\n";
        std::cin >> fileName;
        out = new File(fileName, fileCode);
    } while (!out->isGood());
    out->printString(str);
    delete out;
}

std::string findNumberInString(std::string s)
{
    bool isNumber = false;
    bool wasNumber = false;
    std::string number = "\0";
    for (size_t i = 0; i < s.length(); i++)
    {
        if (!wasNumber && (s[i] == '+' || s[i] == '-'))
        {
            isNumber = true;
            number = "";
            number += s[i];
        }
        else if (isNumber && std::isdigit(s[i]))
        {
            number += s[i];
            wasNumber = true;
        }
        else if (isNumber && wasNumber)
        {
            isNumber = false;
        }
        else if (!wasNumber)
        {
            isNumber = false;
        }
    }
    // if number == "-" or number == "+" we return empty number
    return (wasNumber) ? number : "\0";
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

int main()
{
    Reader* reader = inputMethod();
    std::string answer = findNumberInString(reader->inputString());
    Writer* writer = outputMethod();
    writer->outputString(answer);
    delete reader;
    delete writer;
    return 0;
}