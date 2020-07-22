#include <iostream>
#include <Table.h>
#include "MathFunctions.h"

// a hack square root calculation using simple operations
double mysqrt(double x)
{
  if (x <= 0) {
    return 0;
  }
    double result = x;
  if (1 <= x && x < 10)
  {
    std::cout << "Use the table for init values" << std::endl;
    result = sqrtTable[static_cast<int>(x)];
  }
  // do ten iterations
  for (int i = 0; i < 10; ++i) {
    if (result <= 0) {
      result = 0.1;
    }
    double delta = x - (result * result);
    result = result + 0.5 * delta / result;
    std::cout << "Computing sqrt of " << x << " to be " << result << std::endl;
  }
  return result;
}
