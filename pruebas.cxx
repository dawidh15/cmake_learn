#include <iostream>
#include <string>

int main(int argc, char* argv[])
{
  if (argc < 2) {
    std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }

  int testResult = 1;
  double inpVal = std::stod(argv[1]);
  if (inpVal < 10)
  {
    std::cout << "Test passed" << std::endl;
    testResult = 0;
  } else {
    std::cout << "Test failed" << std::endl;
  }
  return testResult;
}
