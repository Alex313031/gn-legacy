#ifndef HELLOWIN32_DLL_H_
#define HELLOWIN32_DLL_H_

#define WIN32_LEAN_AND_MEAN // Exclude rarely-used stuff from Windows headers

// We need to define _UNICODE and UNICODE for TCHAR
#ifndef UNICODE
 #define UNICODE
#endif

#ifndef _UNICODE
 #define _UNICODE
#endif

#include <windows.h>

#ifndef DLL_EXPORT
 #define DLL_EXPORT __declspec(dllexport)
#endif

extern "C"{

DLL_EXPORT unsigned long long __cdecl TestReturn420();

}

#endif // HELLOWIN32_DLL_H_
