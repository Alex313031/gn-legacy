// Copyright (c) 2025 Alex313031

#include <windows.h>
#include <commctrl.h>
#include <tchar.h>

#include <iostream>
#include <string>

const LPCWSTR kHelloClass = L"HelloWin32Class";

int APIENTRY wWinMain(HINSTANCE hInstance,
                      HINSTANCE hPrevInstance,
                      LPWSTR    lpCmdLine,
                      int       nCmdShow) {
  UNREFERENCED_PARAMETER(hPrevInstance);
  InitCommonControls();
  bool success = false;

  WNDCLASSEXW wcex;
  wcex.cbSize = sizeof(WNDCLASSEX);

  wcex.style          = CS_HREDRAW | CS_VREDRAW;
  wcex.lpfnWndProc    = DefWindowProc;
  wcex.cbClsExtra     = 0;
  wcex.cbWndExtra     = 0;
  wcex.hInstance      = hInstance;
  wcex.hIcon          = LoadIcon(hInstance, IDI_APPLICATION);
  wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
  wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW);
  wcex.lpszMenuName   = L"MainMenu";
  wcex.lpszClassName  = kHelloClass;
  wcex.hIconSm        = (HICON)LoadImage(hInstance,
                                         MAKEINTRESOURCE(5),
                                         IMAGE_ICON, 
                                         GetSystemMetrics(SM_CXSMICON), 
                                         GetSystemMetrics(SM_CYSMICON), 
                                         LR_DEFAULTCOLOR); 

  RegisterClassExW(&wcex);

  HWND hWnd = CreateWindowExW(WS_EX_WINDOWEDGE,
                              kHelloClass,
                              L"Hello Win32!",
                              WS_OVERLAPPEDWINDOW,
                              512,
                              512,
                              400,
                              300,
                              nullptr,
                              nullptr,
                              hInstance,
                              nullptr);
  if (hWnd) {
    ShowWindow(hWnd, nCmdShow);
    UpdateWindow(hWnd);
  }

  MSG msg;
  while (GetMessage(&msg, nullptr, 0, 0)) {
    if (!TranslateAccelerator(msg.hwnd, nullptr, &msg)) {
      TranslateMessage(&msg);
      DispatchMessage(&msg);
    }
  }

  if (success) {
    return 0;
  } else {
    return 1;
  }
}
