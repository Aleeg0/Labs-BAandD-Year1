#include<iostream>


int main()
{
    // intialization
    int n = 0, sum = 0, high = 0, numberInLoop = 1;
    bool goodFlag = false;
    // output the task
    std::cout << "Calculate the sum using the formula (-1)^i * 2^i:\n\n";
    // loop for check inputted symbols
    do
    {
        //input
        std::cout << "Enter n:\n";
        std::cin >> n;
        if (std::cin.get() != '\n')
        {
            std::cin.clear();
            std::cin.ignore(451251, '\n');
            std::cout << "Invalid input!!! Try again\n";
        }
        if (n < 1)
            std::cout << "N cannot be less than 1!!! Try again.\n";
        else // to exit the loop if user entered correct symbols
            goodFlag = true;
    } while (!goodFlag);
    //main block
    high = n + 1;
    for (int i = 1; i < high; i++)
    {
        numberInLoop *= 2;
        if (i % 2 != 0)
            sum -= numberInLoop;
        else
            sum += numberInLoop;
    }
    //output
    std::cout << "Sum equal " << sum << std::endl;
    return 0;
}