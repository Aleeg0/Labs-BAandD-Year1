#include<iostream>
#include<math.h> // for log()
#include<iomanip> // for std::setw() and std::left nad std::right


int main()
{
    // initialization
    int counter = 0; //for input
    double eps = 0.0, xLast = 0.0, x = 0.0;// xLast is x0
    bool isFinding = false, // for task
        goodFlag = false; // for exit loop
    // output the task
    std::cout << "Program solves this example: Ln(7.622x) - 8.59x + 5 = 0.\n"
              << "It's recommended to input epsilon, using standard form.\n"
              << "Example: 1e-9\n"
              << "Or using normal input.\n"
              << "Example: 0.1\n";
    // loop for check inputted eps
    do
    {
        //input
        std::cout << "Enter eps:\n";
        std::cin >> eps;
        if (std::cin.get() != '\n')
        {
            std::cin.clear();
            std::cin.ignore(20000, '\n');
            std::cout << "Invalid type!!! Try again.\n";
        }
        if (eps > 0.1)
            std::cout << "Eps is too big!!! Try again.\n";
        else if (eps < 1.0e-17)
            std::cout << "Eps is too little!!! Try again.\n";
        else // to exit the loop if user entered correct epsilon
            goodFlag = true;

    } while (!goodFlag);
    // output some more info
    std::cout << "To start program also needs to input X0:\n";
    // loop for check inputted X0
    goodFlag = false;
    do
    {
        std::cout << "Enter X0:\n";
        std::cin >> xLast;
        if (std::cin.get() != '\n')
        {
            std::cin.clear();
            std::cin.ignore(20000, '\n');
            std::cout << "Invalid type!!! Try again.\n";
        }
        if (xLast < 0 || xLast == 0)
            std::cout << "X0 cannot be less or equal than 0, because in the task there's the logarithm!!!(7.622x > 0)  Try again.\n";
        // make sure that we can solve this task with current X0
        else if ((double)100 / ((double)859 * xLast) > 1)
            std::cout << "The problem is not solvable using the inputted X0!!! Try again.\n";
        else // to exit the loop if user entered correct limits
            goodFlag = true;

    } while (!goodFlag);
    // main block
    // creating table
    std::cout << std::endl << std::setw(6) << std::left << "   n"
                << std::setw(13) << std::left << "|     x-1" 
                << "|     x" << std::endl
                << "--------------------------------\n";
    while (!isFinding)
    {
        x = (log(7.622 * xLast) + 5) / 8.59;
        // output
        std::cout << std::setw(5) << std::left << counter++ << " | "
                  << std::setw(10) << std::left << xLast << " | "
                  << x << std::endl;
        // if we find the right X
        if (abs(x - xLast) < eps)
            isFinding = true;
        else
            xLast = x;
    };
    // output
    std::cout << "\nThe answer of this task is "
              << x << std::endl;
    return 0;
}