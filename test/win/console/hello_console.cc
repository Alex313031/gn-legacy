// Copyright (c) 2025 Alex313031

#include <windows.h>
#include <tchar.h>

#include <iostream>
#include <string>

#include <hello_static.h>

int main() {
  std::wcout << L"Hello, World! from Win32 Console" << std::endl;
  const unsigned long long testval = TestReturn69();
  std::wcout << L"testval = " << std::hex << testval << std::endl;
  system("pause");
  return 0;
}
