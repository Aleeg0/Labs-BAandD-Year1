#include <iostream>
#include<fstream>


const int MIN_SIZE = 2;

class Reader
{
public:
    virtual size_t inputSize() = 0;
    virtual int* inputArray(const size_t) = 0;
protected:

};

class ConsoleReader : public Reader
{
public:
    virtual size_t inputSize() override;
    virtual int* inputArray(const size_t) override;
private:

};

size_t ConsoleReader::inputSize()
{
    bool isIncorrect = true;
    size_t size = 0;
    // asking for size of array
    do
    {
        std::cout << "Enter the size of array:\n";
        std::cin >> size;
        if (std::cin.get() != '\n')
        {
            std::cin.clear();
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            std::cerr << "Invalid type. Try again.\n";
        }
        else if (size < MIN_SIZE)
            std::cerr << "Size of array cannot be less than " << MIN_SIZE << ".\n";
        else
            isIncorrect = false;
    } while (isIncorrect);
    return size;
}

int* ConsoleReader::inputArray(size_t size)
{
    bool isIncorrect = true;
    int* arr = nullptr;
    // memory allocation of array
    arr = new int[size];
    for (int i = 0; i < size; i++)
    {
        isIncorrect = true;
        do
        {
            std::cout << "Enter " << i + 1 << " element of array:\n";
            std::cin >> arr[i];
            if (std::cin.get() != '\n')
            {
                std::cin.clear();
                std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
                std::cerr << "Invalid type. Try again.\n";
            }
            else
                isIncorrect = false;
        } while (isIncorrect);
    }
    return arr;
}



class File
{
public:
    File() : fileCode((size_t)2), fileStream(nullptr)
    {}
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
    bool isGood();
    bool getStatus();
    size_t getSize();
    int* getArray(const size_t);
    void printArray(int*,const  size_t);
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
    bool isFileExist();
    bool isFileText();
    bool isFileWorking();
    bool isNotEmpty();
};

bool File::getStatus()
{
    return status;
}

int* File::getArray(const size_t size)
{
    fileStream->open(fileName);
    int* arr = new int[size];
    *fileStream >> arr[0];
    for (size_t i = 0; i < size; i++)
    {
        if(status)
        {
            *fileStream >> arr[i];
            if (fileStream->fail())
            {
                fileStream->clear();
                std::cerr << "Invalid type. Check data in the file.\n";
                status = false;
            }
        }
    }
    fileStream->close();
    return arr;
}

size_t File::getSize()
{
    fileStream->open(fileName);
    size_t size = 0;
    *fileStream >> size;
    if (fileStream->fail())
    {
        fileStream->clear();
        std::cerr << "Invalid type. Check data in the file.\n";
        status = false;
    }
    fileStream->close();
    return size;
}

void File::printArray(int* arr, const size_t size)
{
    fileStream->open(fileName);
    for (size_t i = 0; i < size; i++)
    {
        *fileStream << arr[i] << " ";
    }
    std::cout << "Answer has been wrote successfully." << std::endl;
}

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
        {
        }
    }
    return status;
}



class FileReader : public Reader
{
public:
    FileReader() : file(nullptr)
    {};
    size_t inputSize() override;
    int* inputArray(const size_t) override;
    bool getStatus();
    void setFileName();
private:
    size_t fileCode = (size_t)0; // check info about code in class File
    File* file;
};


bool FileReader::getStatus()
{
    return file->getStatus();
}


void FileReader::setFileName()
{
    std::string fileName;
    do
    {
        std::cout << "Enter the name of file in this directory or path to this file including name of file:\n";
        std::cin >> fileName;
        file = new File(fileName, (size_t)0);
    } while (!file->isGood());
}

size_t FileReader::inputSize()
{
    return file->getSize();
}

int* FileReader::inputArray(const size_t size)
{
    return file->getArray(size);
}


class Writer
{
public:
    virtual void outputArray(int*, const size_t) = 0;
protected:

};

class ConsoleWriter : public Writer
{
public:
    void outputArray(int*, const  size_t) override;
private:

};


void ConsoleWriter::outputArray(int* arr, const  size_t size)
{
    std::cout << "Sorted array:\n";
    for (int i = 0; i < size; i++) {
       std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
}


class FileWriter : public Writer
{
public:
    FileWriter() : fileCode((size_t)1)
    { };
    void outputArray(int*, const  size_t) override;
private:
    std::string fileName;
    size_t fileCode = (size_t)1; // check info about code in class File
};

void FileWriter::outputArray(int* arr, const size_t size)
{
    File* out = nullptr;
    do
    {
        delete out;
        std::cout << "Enter the name of file in this directory or path to this file including name of file:\n";
        std::cin >> fileName;
        out = new File(fileName, fileCode);
    } while (!out->isGood());
    out->printArray(arr,size);
    delete out;
}



//functions for main algorithm
void marge(int*& arr, size_t beg1, size_t end1, size_t beg2, size_t end2)
{
    size_t left = 0;
    size_t right = beg2 - beg1;
    size_t size = end2 - beg1 + 1;
    int* copyArr = new int[size];
    //copy part of array
    for (size_t i = 0; i < size; i++)
    {
        copyArr[i] = arr[beg1 + i];
    }
    for (size_t i = beg1; i < beg1 + size; i++)
    {
        if (left + beg1 > end1) {
            arr[i] = copyArr[right++];
        }
        else if (right + beg1 > end2) 
        {
            arr[i] = copyArr[left++];
        }
        else if (copyArr[left] < copyArr[right]) 
        {
            arr[i] = copyArr[left++];
        }
        else 
        {
            arr[i] = copyArr[right++];
        }
    }
    delete[] copyArr;
}

void margeSort(int*& arr, size_t beg, size_t end)
{
    size_t step = 1;
    while (step < end) 
    {
        for (size_t j = beg; j < end - step; j += step * 2)
        {
            marge(arr, j, j + step - (size_t)1, j + step, std::min(j + step * (size_t)2 - (size_t)1, end - (size_t)1));
        }
        step *= 2;
    }
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

void inputTask()
{
    std::cout << "The program sorts array of integers." << std::endl;
}


int main()
{
    bool isIncorrect = true;
    size_t sizeOfArray = 0;
    int* arr = nullptr;
    Reader* reader = nullptr;
    Writer* writer = nullptr;
    inputTask();
    reader = inputMethod();    
    if (FileReader* fileReader = dynamic_cast<FileReader*>(reader))
    {
        do
        {
            fileReader->setFileName();
            sizeOfArray = fileReader->inputSize();
            if (fileReader->getStatus()) {
                arr = fileReader->inputArray(sizeOfArray);
            }
            if (fileReader->getStatus()) {
                isIncorrect = false;
            }
            else
            {
                std::cout << "Read error was detected in your file.\n"
                          << "This program can't continue to read this file.\n";
            }
        } while (isIncorrect);
    }
    else
    {
        sizeOfArray = reader->inputSize();
        arr = reader->inputArray(sizeOfArray);
    }
    margeSort(arr, 0, sizeOfArray);
    writer = outputMethod();
    writer->outputArray(arr, sizeOfArray);
    delete[] arr;
    delete writer;
    delete reader;
    return 0;
}

