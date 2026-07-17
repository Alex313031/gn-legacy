#ifndef HELLO_LINUX_GUI_H_
#define HELLO_LINUX_GUI_H_

// Main C++ headers
#include <cstdlib>
#include <iostream>
#include <sstream>
#include <string>

// GUI toolkit headers
#if defined(USE_GTK)
 #include <gtk/gtk.h>
#elif defined(USE_QT)
 #include <QApplication>
 #include <QPlainTextEdit>
#endif

// Window default width/height
static constexpr int CW_WIDTH  = 480;
static constexpr int CW_HEIGHT = 320;

// Whether we have a display available for GUI.
bool HasDisplay();

// Build output text for console/GUI.
std::wstring BuildText(const std::wstring& toolkit);

#endif // HELLO_LINUX_GUI_H_
