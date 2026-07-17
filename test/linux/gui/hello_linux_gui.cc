// Copyright (c) 2026 Alex313031

// Test for the Linux GUI toolkit pipeline. The toolkit is selected with the
// use_gtk / use_qt build args and pulled in by //build/config/linux:gtk or :qt,
// which also #defines USE_GTK / USE_QT to the configured version. This opens a
// simple window showing a greeting, the static/shared library text, and the
// toolkit + compiler versions -- the Linux analogue of test/win/gui. When no
// display is reachable it prints the same text to stdout and exits, so it stays
// a safe build/CI smoke test; with neither toolkit selected it is console-only.

#include "hello_linux_gui.h"

#include "hello_shared.h"
#include "hello_static.h"

namespace {
// GTK/GLib APIs take UTF-8 char* strings -- unlike the Win32 GUI APIs, which are
// UTF-16 wchar_t. Convert the wide text to UTF-8 at the GTK boundary. (Qt does
// the same job via QString::fromStdWString.)
std::string ToUtf8(const std::wstring& w) {
  std::string out;
  for (wchar_t wc : w) {
    unsigned int c = static_cast<unsigned int>(wc);
    if (c < 0x80) {
      out += static_cast<char>(c);
    } else if (c < 0x800) {
      out += static_cast<char>(0xC0 | (c >> 6));
      out += static_cast<char>(0x80 | (c & 0x3F));
    } else if (c < 0x10000) {
      out += static_cast<char>(0xE0 | (c >> 12));
      out += static_cast<char>(0x80 | ((c >> 6) & 0x3F));
      out += static_cast<char>(0x80 | (c & 0x3F));
    } else {
      out += static_cast<char>(0xF0 | (c >> 18));
      out += static_cast<char>(0x80 | ((c >> 12) & 0x3F));
      out += static_cast<char>(0x80 | ((c >> 6) & 0x3F));
      out += static_cast<char>(0x80 | (c & 0x3F));
    }
  }
  return out;
}

#if defined(USE_GTK) && USE_GTK >= 4
// GTK 4 dropped gtk_main(); drive a GMainLoop and quit it when the window goes
// away (closing the window destroys it by default).
void OnDestroy(GtkWidget* /*widget*/, gpointer loop) {
  g_main_loop_quit(static_cast<GMainLoop*>(loop));
}
#endif
} // namespace

int main(int argc, char* argv[]) {
#if defined(USE_GTK)
  std::wostringstream tk;
  tk << L"GTK " << gtk_get_major_version() << L"." << gtk_get_minor_version()
     << L"." << gtk_get_micro_version() << L" (built against GTK " << USE_GTK
     << L")";
  const std::wstring text = BuildText(tk.str());
  std::wcout << text << std::endl;
 #if USE_GTK >= 4
  if (!gtk_init_check()) {
    std::wcerr << L"Error: No Display available" << std::endl;
    return 1;
  }
  GtkWidget* window = gtk_window_new();
  gtk_window_set_title(GTK_WINDOW(window), "hello_linux_gui");
  gtk_window_set_default_size(GTK_WINDOW(window), CW_WIDTH, CW_HEIGHT);

  GtkWidget* label = gtk_label_new(ToUtf8(text).c_str());
  gtk_label_set_selectable(GTK_LABEL(label), TRUE);
  gtk_window_set_child(GTK_WINDOW(window), label);

  GMainLoop* loop = g_main_loop_new(nullptr, FALSE);
  g_signal_connect(window, "destroy", G_CALLBACK(OnDestroy), loop);
  gtk_window_present(GTK_WINDOW(window));
  g_main_loop_run(loop);
  g_main_loop_unref(loop);
 #else
  if (!gtk_init_check(&argc, &argv)) {
    std::wcerr << L"Error: No Display available" << std::endl;
    return 1;
  }
  GtkWidget* window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title(GTK_WINDOW(window), "hello_linux_gui");
  gtk_window_set_default_size(GTK_WINDOW(window), CW_WIDTH, CW_HEIGHT);

  GtkWidget* label = gtk_label_new(ToUtf8(text).c_str());
  gtk_label_set_selectable(GTK_LABEL(label), TRUE);
  gtk_container_add(GTK_CONTAINER(window), label);

  g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), nullptr);
  gtk_widget_show_all(window);
  gtk_main();
 #endif
#elif defined(USE_QT)
  std::wostringstream tk;
  tk << L"Qt " << qVersion() << L" (built against Qt " << USE_QT << L")";
  const std::wstring text = BuildText(tk.str());

  std::wcout << text << std::endl;
  if (!HasDisplay()) {
    std::wcerr << L"Error: No Display available" << std::endl;
    return 1;
  }

  QApplication app(argc, argv);
  QPlainTextEdit view;
  view.setReadOnly(true);
  view.setPlainText(QString::fromStdWString(text));
  view.setWindowTitle("hello_linux_gui");
  view.resize(CW_WIDTH, CW_HEIGHT);
  view.show();
  return app.exec();
#else
  (void)argc;
  (void)argv;
  std::wcerr << BuildText(L"None (set use_gtk or use_qt)") << std::endl;
#endif
  return 0;
}

// Unlike gtk_init_check(), constructing a QApplication with no display aborts,
// so guard it. (QT_QPA_PLATFORM=offscreen users get the stdout path, which is
// fine for a smoke test.)
bool HasDisplay() {
  return std::getenv("DISPLAY") != nullptr ||
         std::getenv("WAYLAND_DISPLAY") != nullptr;
}

// The text shown in the window (or printed when headless). |toolkit| describes
// the selected GUI toolkit and its version.
std::wstring BuildText(const std::wstring& toolkit) {
  std::wostringstream wostr;
  wostr << L"This is hello_linux_gui\n\n"
     << GetStaticText() << GetSharedText() << L"\n\n"
     << L"Toolkit: " << toolkit << L"\n\n"
     << L"Compiler:\n";
#if defined(__VERSION__)
  wostr << L"  __VERSION__ = " << __VERSION__ << L"\n";
#endif
#if defined(__GNUC__)
  wostr << L"  __GNUC__ = " << __GNUC__ << L"." << __GNUC_MINOR__ << L"."
     << __GNUC_PATCHLEVEL__ << L"\n";
#endif
#if defined(__clang__)
  wostr << L"  __clang__ = " << __clang_major__ << L"." << __clang_minor__ << L"\n";
#endif
#if defined(__cplusplus)
  wostr << L"  __cplusplus = " << __cplusplus << L"\n";
#endif
#if defined(__DATE__)
  wostr << L"  __DATE__ = " << __DATE__ << L"\n";
#endif
  return wostr.str();
}
