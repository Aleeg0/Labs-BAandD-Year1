#include "pch.h"
#include "CppUnitTest.h"
#include "../Exercise 4/Exercise 4.cpp"

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
					{new double[SIZE] {40.0,50.0,60.0}},
					{new double[SIZE] {70.0,80.0,90.0}}
			  }
			  };
			  Assert::AreEqual(findSum(matrix, SIZE), 350.0);
			  free(matrix, SIZE);
		 }
		 TEST_METHOD(TestMethod2)
		 {
			  const int SIZE = 4;
			  double** matrix{ new double* [SIZE] {
					{new double[SIZE] {24.0, 325.0, 23.0, 346.0}},
					{new double[SIZE] {53.0,  23.0,522.0, 124.0}},
					{new double[SIZE] {30.0, 200.0, 15.0,-124.0}},
					{new double[SIZE] {80.0,-214.0, 15.0,-124.0}},
			  } 
			  };
			  Assert::AreEqual(findSum(matrix, SIZE), 1235.0);
			  free(matrix, SIZE);
		 }
		 TEST_METHOD(TestMethod3)
		 {
			  const int SIZE = 4;
			  double** matrix{ new double* [SIZE] {
					{new double[SIZE] {24.325, 325.400, 23.000, 346.346}},
					{new double[SIZE] {53.000,  23.350,522.325, 124.000}},
					{new double[SIZE] {30.463, 200.000, 15.000,-124.124}},
					{new double[SIZE] {80.330,-214.030, 15.053,-124.000}},
			  }
			  };
			  Assert::AreEqual((round(1000.0 * findSum(matrix, SIZE)) / 1000.0), 1237.099);
			  free(matrix, SIZE);
		 }
		 TEST_METHOD(TestMethod4)
		 {
			  const int SIZE = 10;
			  double** matrix{ new double* [SIZE] {
					{new double[SIZE] { 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0}}, //55
					{new double[SIZE] {11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0, 20.0}}, //124
					{new double[SIZE] {21.0,22.0,23.0,24.0,25.0,26.0,27.0,28.0,29.0, 30.0}}, //153
					{new double[SIZE] {31.0,32.0,33.0,34.0,35.0,36.0,37.0,38.0,39.0, 40.0}}, //142
					{new double[SIZE] {41.0,42.0,43.0,44.0,45.0,46.0,47.0,48.0,49.0, 50.0}}, //91
					{new double[SIZE] {51.0,52.0,53.0,54.0,55.0,56.0,57.0,58.0,59.0, 60.0}}, //111
					{new double[SIZE] {61.0,62.0,63.0,64.0,65.0,66.0,67.0,68.0,69.0, 70.0}}, //262
					{new double[SIZE] {71.0,72.0,73.0,74.0,75.0,76.0,77.0,78.0,79.0, 80.0}}, //453
					{new double[SIZE] {81.0,82.0,83.0,84.0,85.0,86.0,87.0,88.0,89.0, 90.0}}, //684
					{new double[SIZE] {91.0,92.0,93.0,94.0,95.0,96.0,97.0,98.0,99.0,100.0}}  //955
			  } 
			  };
			  Assert::AreEqual(findSum(matrix, SIZE), 3030.00);
			  free(matrix, SIZE);
		 }
	};
}
