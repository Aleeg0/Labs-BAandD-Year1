#include<iostream>
#include<math.h>
#include<iomanip>//for foramtting output data

int main()
{
    //initialization
    double num1 = 0, num2 = 0, arithmeticAvg = 0, geometricAvg = 0;
    bool goodFlag = false; // for loop if wrong input
    //output the task
    std::cout << "  The program is proving that arithmetic average of two unsigned\n"
        << "double numbers bigger or equal than geometric average of this numbers.\n\n";
    //loop for check inputted symbols
    do
    {
        try
        {
            //input 
            std::cout << "Enter first unsigned double number:\n";
            std::cin >> num1;
            if (std::cin.get() != '\n') // if there's a char instead of double
            {
                std::cin.clear();
                std::cin.ignore(32767, '\n');
                throw std::exception("Invalid type!!!");
            }
            if (num1 < 0)
                throw std::exception("Entering number cannot be less than 1!!!");
            std::cout << "Enter second unsigned double number:\n";
            std::cin >> num2;
            if (std::cin.get() != '\n')  // if there's a char instead of double 
            {
                std::cin.clear();
                std::cin.ignore(32767, '\n');
                throw std::exception("Invalid type!!!");
            }
            if (num2 < 0)
                throw std::exception("Entering number cannot be less than 1!!!");
            goodFlag = true; // to exit the loop if user entered correct symbols 
        }
        catch (const std::exception& ex)
        {
            std::cout << ex.what() << " Try again.\n\n";
        }
    } while (!goodFlag);
    //main block
    arithmeticAvg = (num1 + num2) / 2;
    geometricAvg = sqrt(num1 * num2);
    //output
    std::cout << "\nArithmetic average: " << arithmeticAvg
        << "\nGeometric average: " << std::fixed << std::setprecision(4) << geometricAvg
        << ((arithmeticAvg == geometricAvg)
            ? "\nArithmetic average = Geometricaverage\n"
            : "\nGeometric average > Arithmetic average\n");
    return 0;
}