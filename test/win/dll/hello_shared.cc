#include "hello_shared.h"

extern "C"{

DLL_EXPORT unsigned long long __cdecl TestReturn420() {
  const unsigned long long lit = 0x0420LL;
  return lit;
}

}
