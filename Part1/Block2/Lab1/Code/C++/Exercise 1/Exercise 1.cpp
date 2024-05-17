#include<iostream>


int main()
{
    //initialization
    int n = 0;
    double a = 0.0, b = 0.0, c = 0.0, highestSquare = -1.0, currentSquare = -1.0,
        p = 0.0; // half-perimeter
    bool isIncorrect = true;
    std::cout << "The program finding a triangle with the highest square.\n\n";
    // make sure that user enter correct size
    do
    {
        std::cout << "Enter how many triangles: ";
        std::cin >> n;
        if (std::cin.get() != '\n')
        {
            std::cin.clear();
            std::cin.ignore(4124,'\n');
            std::cerr << "Invalid type!!! Try again.\n";
        }
        else if (n < 1)
            std::cerr << "Entering number cannot be less than 1!!! Try again.\n";
        else
            isIncorrect = false;
    } while (isIncorrect);
    // input sides of triangles
    for (int i = 0; i < n; i++)
    {
        do
        {
            //inputting first side
            isIncorrect = true;
            do
            {
                std::cout << "Enter first side of triangle number " << i + 1 << ": ";
                std::cin >> a;
                if (std::cin.get() != '\n')
                {
                    std::cin.clear();
                    std::cin.ignore(4211,'\n');
                    std::cerr << "Invalid type!!! Try again.\n";
                }
                else if (a < 0.0 || a == 0.0)
                    std::cerr << "Side cannot be less than 0!!! Try again.\n";
                else
                    isIncorrect = false;
            } while (isIncorrect);
            //inputting second side
            isIncorrect = true;
            do
            {
                std::cout << "Enter second side of triangle number " << i + 1 << ": ";
                std::cin >> b;
                if (std::cin.get() != '\n')
                {
                    std::cin.clear();
                    std::cin.ignore(4211,'\n');
                    std::cerr << "Invalid type!!! Try again.\n";
                }
                else if (b < 0.0 || b == 0.0)
                    std::cerr << "Side cannot be less than 0!!! Try again.\n";
                else
                    isIncorrect = false;
            } while (isIncorrect);
            //inputting third side
            isIncorrect = true;
            do
            {
                std::cout << "Enterse third side of triangle number " << i + 1 << ": ";
                std::cin >> c;
                if (std::cin.get() != '\n')
                {
                    std::cin.clear();
                    std::cin.ignore(4512,'\n');
                    std::cerr << "Invalid type!!! Try again.\n";
                }
                else if (c < 0.0 || c == 0.0)
                    std::cerr << "Side cannot be less than 0!!! Try again.\n";
                else
                    isIncorrect = false;
            } while (isIncorrect);
            // check the triangle for correctness
            if (a + b > c && a + c > b && b + c > a)
                isIncorrect = false;
            else
            {
                std::cerr << "Triangle with sides " << a << " " << b << " " << c << " doesn't exist.\n";
                isIncorrect = true;
            }
        } while (isIncorrect);
        // making counts
        p = (a + b + c) / 2.0;
        currentSquare = sqrt(p * (p - a) * (p - b) * (p - c));
        (currentSquare > highestSquare) ? highestSquare = currentSquare : highestSquare;
    }
    // output
    std::cout << "The best triangle has square qeual " << highestSquare << std::endl;
    return 0;
}