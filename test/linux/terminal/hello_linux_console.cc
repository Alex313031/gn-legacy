#include <iostream>
#include <sstream>
#include <string>

#include "hello_shared.h"
#include "hello_static.h"

int main(int argc, char* argv[]) {
  std::wostringstream wostr;
  wostr << GetStaticText() << GetSharedText();
  const std::wstring out_text = wostr.str();
  std::wcout << out_text << std::endl;
  return 0;
}
