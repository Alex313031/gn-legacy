#include <stdio.h>

#include "hello_shared.h"
#include "hello_static.h"

int main(int argc, char* argv[]) {
  printf("%s%s\n", GetStaticText(), GetSharedText());
  return 0;
}
