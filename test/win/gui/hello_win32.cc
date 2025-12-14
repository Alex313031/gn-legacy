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
  hTextOut = CreateWindowExW(0, L"EDIT", nullptr,
      WS_CHILD | WS_VISIBLE | WS_BORDER | ES_MULTILINE | ES_AUTOVSCROLL | ES_AUTOHSCROLL,
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

BOOL InitInstance(HINSTANCE hInstance, int nCmdShow) {
  bool success = false;
  gHinst = hInstance;
  std::wostringstream wostr;
  const unsigned long long testval = TestReturn69();
  const unsigned long long testval2 = TestReturn420();
  wostr << L"salute.lib testval = " << std::hex << testval << L"\r\n"
        << L"heller.dll testval2 = " << testval2 << std::dec << std::endl;
  const std::wstring out = wostr.str();
  textout = out;
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
  switch (message) {
    case WM_INITDIALOG:
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
