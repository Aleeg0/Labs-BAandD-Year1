#include "pch.h"
#include "CppUnitTest.h"
#include "../Exercise 2/Exercise 2.cpp"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace Test
{
	TEST_CLASS(Test)
	{
	public:
		
		TEST_METHOD(TestMethod1)
		{
			 Assert::AreEqual(findNumber(4),{12,24,36,48});
		}
	};
}
