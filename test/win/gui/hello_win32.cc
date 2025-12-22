// Copyright (c) 2025 Alex313031

#include "hello_win32.h"

#include <iostream>
#include <sstream>

HINSTANCE gHinst;

HWND hTextOut;

static std::wstring textout;

int APIENTRY wWinMain(HINSTANCE hInstance,
                      HINSTANCE hPrevInstance,
                      LPWSTR    lpCmdLine,
                      int       nCmdShow) {
  UNREFERENCED_PARAMETER(hPrevInstance);
  InitCommonControls();

  RegisterWndClass(hInstance);

  if (!InitInstance(hInstance, nCmdShow)) {
    return 1;
  }

  HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_HELLOWORLD));

  MSG msg;
  while (GetMessage(&msg, nullptr, 0, 0)) {
    if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg)) {
      TranslateMessage(&msg);
      DispatchMessage(&msg);
    }
  }

  return static_cast<int>(msg.wParam);
}

void AppendTextToEditControl(HWND hWnd, const std::wstring line) {
  const WCHAR* text = line.c_str();
  int length = GetWindowTextLength(hWnd); // Get current text length
  SendMessageW(hWnd, EM_SETSEL, (WPARAM)length, (LPARAM)length); // Set cursor at the end
  SendMessageW(hWnd, EM_REPLACESEL, FALSE, (LPARAM)text); // Append the text
}

void OutputText(HWND hWnd) {
  hTextOut = CreateWindowExW(0, WC_EDIT, nullptr,
      WS_CHILD | WS_VISIBLE | WS_BORDER | ES_MULTILINE | ES_AUTOVSCROLL | WS_VSCROLL,
      6, 6, 300, 200, hWnd, (HMENU)IDC_TEXT1, gHinst, nullptr);
  AppendTextToEditControl(hTextOut, textout);
}

ATOM RegisterWndClass(HINSTANCE hInstance) {
  WNDCLASSEXW wcex;
  wcex.cbSize = sizeof(WNDCLASSEX);

  wcex.style          = CS_HREDRAW | CS_VREDRAW;
  wcex.lpfnWndProc    = WindowProc;
  wcex.cbClsExtra     = 0;
  wcex.cbWndExtra     = 0;
  wcex.hInstance      = hInstance;
  wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_HELLOWORLD));
  wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
  wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW);
  wcex.lpszMenuName   = MAKEINTRESOURCEW(IDC_HELLOWORLD);
  wcex.lpszClassName  = kHelloWin32Class;
  wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

  return RegisterClassExW(&wcex);
}

const std::wstring GetVersionW() {
  std::wostringstream wostr;
  wostr << VERSION_STRING;
  const std::wstring retval = wostr.str();
  return retval;
}

static const std::wstring GetOutput() {
  std::wostringstream wostr;
  const unsigned long long testval = TestReturn69();
  const unsigned long long testval2 = TestReturn420();
  wostr << L"Hello World!" << L"\r\n" << L"This is hello_win32.exe ver. "
        << GetVersionW() << L"\r\n\r\n";
  wostr << L"The following lines check that the static and dynamic libraries were compiled/loaded correctly:" << L"\r\n\r\n";
  wostr << L"salute.lib testval = " << std::hex << testval << L"\r\n"
        << L"heller.dll testval2 = " << testval2 << std::dec << L"\r\n";
  wostr << L"The following lines check compiler DEFINEs" << L"\r\n\r\n";
#if defined(__DATE__)
  wostr << L"__DATE__ = " << __DATE__ << L"\r\n";
#endif
#if defined(_WIN32)
  wostr << L" _WIN32 = " << TRUE << L"\r\n";
#endif
#if defined(_WIN64)
  wostr << L" _WIN64 = " << TRUE << L"\r\n";
#endif
#if defined(__clang__)
  wostr << L"__clang__ = " << TRUE << L"\r\n";
#endif
#if defined(__MINGW32__)
  wostr << L"__MINGW32__ = " << __VERSION__ << L"\r\n";
#endif
#if defined(__GNUC__)
  wostr << L"__GNUC__ = " << __GNUC__ << __GNUC_MINOR__ << __GNUC_PATCHLEVEL__ << L"\r\n";
#endif
#if defined(__MSC_VER__)
  wostr << L"__MSC_VER__ = " << _MSC_FULL_VER << L"\r\n";
#endif
#if defined(_M_FP_FAST)
  wostr << L"_M_FP_FAST = " << TRUE << L"\r\n";
#endif
#if defined(__STRICT_ANSI__)
  wostr << L"__STRICT_ANSI__ = " << TRUE << L"\r\n";
#endif
#if defined(__SIZE_MAX__)
  wostr << L"__SIZE_MAX__ = " << __SIZE_MAX__ << L"\r\n";
#endif
#if defined(__SHRT_MAX__)
  wostr << L"__SHRT_MAX__ = " << __SHRT_MAX__ << L"\r\n";
#endif
#if defined(__INT_MAX__)
  wostr << L"__INT_MAX__ = " << __INT_MAX__ << L"\r\n";
#endif
#if defined(__INT8_MAX__)
  wostr << L"__INT8_MAX__ = " << __INT8_MAX__ << L"\r\n";
#endif
#if defined(__INT16_MAX__)
  wostr << L"__INT16_MAX__ = " << __INT16_MAX__ << L"\r\n";
#endif
#if defined(__INT32_MAX__)
  wostr << L"__INT32_MAX__ = " << __INT32_MAX__ << L"\r\n";
#endif
#if defined(__INT64_MAX__)
  wostr << L"__INT64_MAX__ = " << __INT64_MAX__ << L"\r\n";
#endif
#if defined(__INTMAX_MAX__)
  wostr << L"__INTMAX_MAX__ = " << __INTMAX_MAX__ << L"\r\n";
#endif
#if defined(__UINT8_MAX__)
  wostr << L"__UINT8_MAX__ = " << __UINT8_MAX__ << L"\r\n";
#endif
#if defined(__UINT16_MAX__)
  wostr << L"__UINT16_MAX__ = " << __UINT16_MAX__ << L"\r\n";
#endif
#if defined(__UINT32_MAX__)
  wostr << L"__UINT32_MAX__ = " << __UINT32_MAX__ << L"\r\n";
#endif
#if defined(__UINT64_MAX__)
  wostr << L"__UINT64_MAX__ = " << __UINT64_MAX__ << L"\r\n";
#endif
#if defined(__UINTMAX_MAX__)
  wostr << L"__UINTMAX_MAX__ = " << __UINTMAX_MAX__ << L"\r\n";
#endif
#if defined(__LONG_MAX__)
  wostr << L"__LONG_MAX__ = " << __LONG_MAX__ << L"\r\n";
#endif
#if defined(__LONG_LONG_MAX__)
  wostr << L"__LONG_LONG_MAX__ = " << __LONG_LONG_MAX__ << L"\r\n";
#endif
#if defined(__CHAR_BIT__)
  wostr << L"__CHAR_BIT__ = " << __CHAR_BIT__ << L"\r\n";
#endif
#if defined(__WINT_MAX__)
  wostr << L"__WINT_MAX__ = " << __WINT_MAX__ << L"\r\n";
#endif
#if defined(__WINT_MIN__)
  wostr << L"__WINT_MIN__ = " << __WINT_MIN__ << L"\r\n";
#endif
#if defined(__WCHAR_MAX__)
  wostr << L"__WCHAR_MAX__ = " << __WCHAR_MAX__ << L"\r\n";
#endif
#if defined(__WCHAR_MIN__)
  wostr << L"__WCHAR_MIN__ = " << __WCHAR_MIN__ << L"\r\n";
#endif
  wostr<< std::endl;
  const std::wstring out = wostr.str();
  return out;
}

BOOL InitInstance(HINSTANCE hInstance, int nCmdShow) {
  bool success = false;
  gHinst = hInstance;
  textout = GetOutput();
  HWND hWnd = CreateWindowExW(WS_EX_WINDOWEDGE,
                              kHelloWin32Class,
                              kHelloWin32Title,
                              WS_OVERLAPPEDWINDOW,
                              512,
                              512,
                              400,
                              300,
                              nullptr,
                              nullptr,
                              hInstance,
                              nullptr);
  if (!hWnd) {
    success = false;
  } else {
    ShowWindow(hWnd, nCmdShow);
    UpdateWindow(hWnd);
    success = true;
  }
  return success;
}

LRESULT CALLBACK WindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
  switch (uMsg) {
    case WM_COMMAND: {
      int wmId = LOWORD(wParam);
      switch (wmId) {
        case IDM_ABOUT:
          DialogBoxW(gHinst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, AboutDlgProc);
          break;
        case IDM_HELP:
          MessageBoxW(hWnd, L"No Help implemented yet", L"Help", MB_OK | MB_ICONINFORMATION);
          break;
        case IDM_EXIT:
          DestroyWindow(hWnd);
          break;
        default:
          return DefWindowProc(hWnd, uMsg, wParam, lParam);
      }
    } break;
    case WM_CREATE: {
      OutputText(hWnd);
    } break;
    case WM_GETMINMAXINFO: {
      LPMINMAXINFO pMinMaxInfo = (LPMINMAXINFO)lParam;
      pMinMaxInfo->ptMinTrackSize.x = 228;
      pMinMaxInfo->ptMinTrackSize.y = 128;
    } break;
    case WM_SIZE: {
      int width = LOWORD(lParam);
      int height = HIWORD(lParam);
      MoveWindow(hTextOut, 6, 6, width - 12, height - 12, TRUE);
    } break;
    // Begin painting
    case WM_PAINT: {
      PAINTSTRUCT ps;
      HDC hdc = BeginPaint(hWnd, &ps);
      // TODO: Add any drawing code that uses hdc here...
      if (hdc) {
      }
      EndPaint(hWnd, &ps);
    } break;
    case WM_CLOSE:
      PostQuitMessage(0);
      break;
    case WM_DESTROY:
      PostQuitMessage(0);
      break;
    default:
      return DefWindowProc(hWnd, uMsg, wParam, lParam);
  }
  return 0;
}

INT_PTR CALLBACK AboutDlgProc(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam) {
  UNREFERENCED_PARAMETER(lParam);

  bool AboutHandled = false;
  const HICON kSmallIcon = LoadIcon(GetHinstanceFromHwnd(hDlg), MAKEINTRESOURCE(IDI_SMALL));
  switch (message) {
    case WM_INITDIALOG:
      SendMessage(hDlg, WM_SETICON, ICON_SMALL, (LPARAM)kSmallIcon);
      SendMessage(hDlg, WM_SETICON, ICON_BIG, (LPARAM)kSmallIcon);
      AboutHandled = true;
      break;
    case WM_COMMAND:
      // Exit the dialog
      if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL) {
        if (EndDialog(hDlg, LOWORD(wParam))) {
          AboutHandled = true;
          break;
        } else {
          AboutHandled = false;
          break;
        }
      } break;
    default:
      break;
  }

  // About dialog failed
  return (INT_PTR)AboutHandled;
}

// Grabs the HINSTANCE of a given Window's HWND
HINSTANCE GetHinstanceFromHwnd(HWND hWnd) {
  // GetWindowLongPtr is the recommended function for 64-bit compatibility
  LONG_PTR hInstancePtr = GetWindowLongPtr(hWnd, GWLP_HINSTANCE);
  // Cast the result to HINSTANCE
  HINSTANCE hInstance = reinterpret_cast<HINSTANCE>(hInstancePtr);

  return hInstance;
}
