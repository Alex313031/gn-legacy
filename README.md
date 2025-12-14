# GN Simple

### GN Simple Build Boilerplate for Legacy Win32

This is specifically designed for using MinGW (LLVM on Linux, W64DevKit on Windows)
to target legacy versions of Windows. This makes building small or large C/C++ projects
faster and easier than any method besides Makfiles. Makefiles don't have the cross
platform extensibility that GN provides, or the compilation speed that Ninja provides.

Existing projects that fix the above can't target anything older than Windows 7,
that's where this project comes in.

This is an example directory structure that compiles some simple targets using
gcc. It is intended to show how to set up a simple GN build. It is deliberately
simplistic so the structure is more clear, and doesn't support everything on
every platform. It has minimal support for Linux, but almost all support is for Windows.

