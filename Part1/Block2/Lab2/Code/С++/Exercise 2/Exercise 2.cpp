#include<iostream>

const int minRangeOfInteger32 = -2147483648;
const int maxRangeOfInteger32 = 2147483647;
const int maxK = 10000000;
const int minK = 1;
const int maxDigit = 9;
const int maxDigits = 10;

void input(int& k)
{
    bool isIncorrect = true;
    std::cout << "The program finds all natural numbers that are k times greater than the sum of their digits.\n";
    do
    {
        std::cout << "Enter the number from "<< minK << " to " << maxK << ".\n";
        std::cin >> k;
        if (std::cin.get() != '\n')
        {
            std::cin.clear();
            std::cin.ignore(5323, '\n');
            std::cout << ((k == maxRangeOfInteger32 || k == minRangeOfInteger32)
                ? "The entering number not in range of Integer32!" : "Invalid type!");
            std::cout << " Try again.\n";
        }
        else if (k < minK)
        {
            std::cout << "The entered number cannot be less than " << minK << "! Try again.\n";
        }
        else if (maxK < k)
            std::cout << "The entered number cannot be more than " << maxK << "! Try again.\n";
        else
            isIncorrect = false;
    } while (isIncorrect);
}

inline void output(int& naturalNumber)
{
    std::cout << naturalNumber << " ";
}

int digitsSum(int naturalNumber)
{
    int sum = 0;
    while (naturalNumber)
    {
        sum += naturalNumber % 10;
        naturalNumber /= 10;
    }
    return sum;
}

int findMaxNumber(const int& k)
{
    int maxNumber = 1;
    int countOfDigits = 1;
    while (countOfDigits < maxDigits && k * maxDigit * countOfDigits++ > maxNumber)
    {
        maxNumber *= 10;
    };
    return maxNumber /= 10;
}



void findNumbers(int& k)
{
    int naturalNumber = k;
    int maxNumber = findMaxNumber(k);
    while (naturalNumber < maxNumber)
    {
        if (naturalNumber == digitsSum(naturalNumber) * k)
            output(naturalNumber);
        naturalNumber += k;
    }
}

int main()
{
    int k = 0;
    input(k);
    findNumbers(k);
    return 0;
}
