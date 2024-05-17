#include "pch.h"
#include "CppUnitTest.h"
#include "../Exercise3/Exercise3.cpp"
#include <vector>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;



namespace UnitTest1
{
	 TEST_CLASS(UnitTest1)
	 {
	 public:
		  TEST_METHOD(TestMethod1)
		  {
				const int SIZE = 3;
				double** matrix{ new double* [SIZE] { 
					 {new double[SIZE] {10.0,20.0,30.0}},
					 {new double[SIZE] {30.0,40.0,50.0}},
					 {new double[SIZE] {60.0,70.0,80.0}} 
				}};
				Assert::AreEqual(findBestSum(matrix, SIZE), 150.0);
				free(matrix, SIZE);
		  }
		  TEST_METHOD(TestMethod2)
		  {
				const int SIZE = 3;
				double** matrix{ new double* [SIZE] {
					 {new double[SIZE] {50.0,40.0,50.0}},
					 {new double[SIZE] {90.0,120.0,30.0}},
					 {new double[SIZE] {30.0,200.0,15.0}}
				} };
				Assert::AreEqual(findBestSum(matrix, SIZE), 320.0);
				free(matrix, SIZE);
		  }
		  TEST_METHOD(TestMethod3)
		  {
				const int SIZE = 3;
				double** matrix{ new double* [SIZE] {
					 {new double[SIZE] {15.25, 17.35,13.46}},
					 {new double[SIZE] {35.00,-12.89,17.34}},
					 {new double[SIZE] {20.50,-232.0, 0.00}}
				} };
				Assert::AreEqual(findBestSum(matrix, SIZE), 55.50);
				free(matrix, SIZE);
		  }
	 };
}
