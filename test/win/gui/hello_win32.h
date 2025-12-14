#ifndef HELLOWIN32_MAIN_H_
#define HELLOWIN32_MAIN_H_

#include "version.h"

#include <windows.h>
#include <commctrl.h>
#include <tchar.h>

#include <hello_static.h>
#include <hello_shared.h>

#include <string>

#include "resource.h"

extern HINSTANCE gHinst;

extern HWND hTextOut;

static const LPCWSTR kHelloWin32Title = L"Hello World Win32";

const LPCWSTR kHelloWin32Class = L"HelloWin32Class";

static void AppendTextToEditControl(HWND hWnd, const std::wstring line);

static const std::wstring GetVersionW();

void OutputText(HWND hWnd);

ATOM RegisterWndClass(HINSTANCE hInstance);

BOOL InitInstance(HINSTANCE hInstance, int nCmdShow);

LRESULT CALLBACK WindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

INT_PTR CALLBACK AboutDlgProc(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam);

#endif // HELLOWIN32_MAIN_H_
