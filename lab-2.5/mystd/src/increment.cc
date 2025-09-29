#include "mystd.hh"

namespace mystd {

long increment(long i) {
  int result = 0;
  asm (
    "mov x0, #1       \n"
    "add %1, %0, x0   \n"
    : "=r" (i), "=r" (result)
    : "0" (i), "1" (result)
    : "x0"
  );
  return result;
}

}
