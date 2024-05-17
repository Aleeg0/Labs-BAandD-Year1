#include <iostream>


int main()
{
    //initialization 
    int n = 0;
    int* list1 = nullptr;
    bool goodFlag = false;
    // output the task
    std::cout << "Program  outputs a new array, by using data entered"
              << " array, according to this formula b[k]=2 * a[k]+k.\n";
    // loop for check inputted size
    do
    {
        try
        {
            std::cout << "Enter size of array:\n";
            std::cin >> n;
            if (std::cin.get() != '\n')
            {
                std::cin.clear();
                std::cin.ignore(35125, '\n');
                throw std::exception("Invalid type!!!");
            }
            if (n < 1)
                throw std::exception("N cannot be less than 1!!!");
            goodFlag = true; // to exit the loop if user entered correct size
        }
        catch (const std::exception& ex)
        {
            std::cout << ex.what() << " Try again.\n";
        }
    } while (!goodFlag);
    // memory allocation of the first array
    list1 = new int[n];
    // output more info
    std::cout << "Enter numbers, which you want to add in array:\n";
    // loop for check inputted numbers in array
    goodFlag = false;
    do
    {
        try
        {
            for (int i = 0; i < n; i++)
            {
                int number = 0;
                std::cout << "Enter " << i + 1 << " number:\n";
                std::cin >> number;
                if (std::cin.get() != '\n')
                {
                    std::cin.clear();
                    std::cin.ignore(35125, '\n');
                    throw std::exception("Invalid type!!!");
                }
                *(list1 + i) = number;
            }
            goodFlag = true; // to exit the loop if user entered correct numbers
        }
        catch (const std::exception& ex)
        {
            std::cout << ex.what() << " Try again.\n";
        }

    } while (!goodFlag);
    //main block
    int* list2 = new int[n];
    for (int i = 0; i < n; i++)
    {
        //all good! If u have warning, don't pay attantion to the warning 
        *(list2 + i) = *(list1 + i) * 2 + i + 1; 
    }
    delete[] list1; // free allocated memory
    list1 = nullptr; // do to avoid unsave piece of memory and to avoid RTError 
    //output
    std::cout << "Array after transformation:\n";
    for (int i = 0; i < n; i++)
    {
        std::cout << "Number " << i + 1 << " in array: " << *(list2 + i) << std::endl;
    }
    delete[] list2;// free allocated memory
    list2 = nullptr; // do to avoid unsave piece of memory and to avoid RTError 
    return 0;
}


