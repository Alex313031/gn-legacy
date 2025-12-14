// Copyright (c) 2025 Alex313031

#include "hello_win32.h"

#include <iostream>
#include <string>

const LPCWSTR kHelloWin32Class = L"HelloWin32Class";
const LPCWSTR kHelloWin32Title = L"Hello World Win32";

ATOM RegisterWndClass(HINSTANCE hInstance);

BOOL InitInstance(HINSTANCE hInstance, int nCmdShow);

LRESULT CALLBACK WindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

int APIENTRY wWinMain(HINSTANCE hInstance,
                      HINSTANCE hPrevInstance,
                      LPWSTR    lpCmdLine,
                      int       nCmdShow) {
  UNREFERENCED_PARAMETER(hPrevInstance);
  InitCommonControls();

  const unsigned long long testval = TestReturn69();
  const unsigned long long testval2 = TestReturn420();
  std::wcout << L"testval = " << std::hex << testval << std::endl;
  std::wcout << L"testval2 = " << std::hex << testval2 << std::endl;

  RegisterWndClass(hInstance);

  if (!InitInstance(hInstance, nCmdShow)) {
    return 1;
  }

  MSG msg;
  while (GetMessage(&msg, nullptr, 0, 0)) {
    if (!TranslateAccelerator(msg.hwnd, 0, &msg)) {
      TranslateMessage(&msg);
      DispatchMessage(&msg);
    }
  }

  return static_cast<int>(msg.wParam);
}

ATOM RegisterWndClass(HINSTANCE hInstance) {
  WNDCLASSEXW wcex;
  wcex.cbSize = sizeof(WNDCLASSEX);

  wcex.style          = CS_HREDRAW | CS_VREDRAW;
  wcex.lpfnWndProc    = WindowProc;
  wcex.cbClsExtra     = 0;
  wcex.cbWndExtra     = 0;
  wcex.hInstance      = hInstance;
  wcex.hIcon          = LoadIcon(hInstance, IDI_APPLICATION);
  wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
  wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW);
  wcex.lpszMenuName   = MAKEINTRESOURCEW(IDC_CRYOCALC);
  wcex.lpszClassName  = kHelloWin32Class;
  wcex.hIconSm        = (HICON)LoadImage(hInstance,
                                         MAKEINTRESOURCE(5),
                                         IMAGE_ICON, 
                                         GetSystemMetrics(SM_CXSMICON), 
                                         GetSystemMetrics(SM_CYSMICON), 
                                         LR_DEFAULTCOLOR); 

  return RegisterClassExW(&wcex);
}

BOOL InitInstance(HINSTANCE hInstance, int nCmdShow) {
  bool success = false;
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

// Window procedure for handling messages
LRESULT CALLBACK WindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
  switch (uMsg) {
    case WM_COMMAND: {
      int wmId = LOWORD(wParam);
      switch (wmId) {
        case IDM_ABOUT:
          //ShowAboutDialog(hWnd);
          break;
        case IDM_HELP:
          //LaunchHelp(hWnd);
          break;
        case IDM_EXIT:
          // Send WM_DESTROY message to close window 
          DestroyWindow(hWnd);
          break;
        default:
          return DefWindowProc(hWnd, uMsg, wParam, lParam);
      }
    } break;
    case WM_DESTROY:
      PostQuitMessage(0);
      break;
    default:
      return DefWindowProc(hWnd, uMsg, wParam, lParam);
  }
  return 0;
}
