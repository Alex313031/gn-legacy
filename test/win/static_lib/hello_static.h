#ifndef HELLOWIN32_STATIC_LIB_H_
#define HELLOWIN32_STATIC_LIB_H_

#define WIN32_LEAN_AND_MEAN // Exclude rarely-used stuff from Windows headers

// We need to define _UNICODE and UNICODE for TCHAR
#ifndef UNICODE
 #define UNICODE
#endif

#ifndef _UNICODE
 #define _UNICODE
#endif

#include <windows.h>

#ifndef LIB_IMPORT
 #define LIB_IMPORT __declspec(dllimport)
#endif

extern "C"{

unsigned long long __cdecl TestReturn69();

}

#endif // HELLOWIN32_STATIC_LIB_H_
