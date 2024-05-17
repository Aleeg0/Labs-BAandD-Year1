using System.Collections.Immutable;

namespace Lab6_2;

public class MSquareBuilder
{
    private int offset;

    private int highSize;
    
    private int size;
    
    private int[,] helpMatrix;

    private int[,] matrix;
    
    public int[,] Matrix
    {
        get
        {
            for (int i = 0; i < size; i++)
            {
                for (int j = 0; j < size; j++)
                {
                    matrix[i, j] = helpMatrix[i + offset, j + offset];
                }   
            }

            return matrix;
        }
    }
    
    public MSquareBuilder(int size)
    {
        this.highSize = size * 2 - 1;
        this.size = size;
        this.offset = this.size / 2;
        helpMatrix = new int[highSize,highSize];
        matrix = new int[size, size];
    }

    public void BuildHugeMatrix()
    {
        int j = 0;
        int i = 0;
        offset = size / 2;
        
        // fill matrix with zeros
        for (i = 0; i < highSize; i++)
            for (j = 0; j < highSize; j++)
                helpMatrix[i, j] = 0;
        // create matrix with diagonal elements
        i = 0;
        j = 0;
        int number = 1;
        for (int step1 = size - 1; step1 < highSize; step1++)
        {
            i = step1;
            for (int step2 = 0; step2 < size; step2++)
                helpMatrix[i--, j++] = number++;
            j = j - size + 1;    
        }
        
    }

    public void MoveLeftPart()
    {
        int i, j, k;
        k = offset + 1;
        while (k < offset + size - 1)
        {
            i = k;
            j = offset - 1;
            while (j > -1 && helpMatrix[i,j] != 0)
            {
                helpMatrix[i,j + size] = helpMatrix[i, j];
                helpMatrix[i++,j--] = 0;
            }
            k += 2;
        }
    }
    
    public void MoveTopPart()
    {
        int i, j, k;
        k = offset + 1;
        while (k < offset + size - 1)
        {
            i = offset - 1;
            j = k;
            while (i > -1 && helpMatrix[i,j] != 0)
            {
                helpMatrix[i + size, j] = helpMatrix[i, j];
                helpMatrix[i--, j++] = 0;
            }
            k += 2;
        }
    }
    
    public void MoveRightPart()
    {
        int i, j, k;
        k = offset + 1;
        while (k < offset + size - 1)
        {
            i = k;
            j = highSize - offset;
            while ((j < highSize) && helpMatrix[i,j] != 0)
            {
                helpMatrix[i, j - size] = helpMatrix[i, j];
                helpMatrix[i++, j++] = 0;
            }
            k += 2;
        }    
    }
    
    public void MoveBottomPart()
    {
        int i, j, k;
        k = offset + 1;
        while (k < offset + size - 1)
        {
            i = highSize - offset;
            j = k;
            while (i < highSize && helpMatrix[i,j] != 0)
            {
                helpMatrix[i - size, j] = helpMatrix[i, j];
                helpMatrix[i++, j++] = 0;
            }
            k += 2;
        }     
    }
    
}