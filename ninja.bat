:: Copyright (c) 2026 Alex313031

:: Windows Ninja wrapper for GN-Legacy

:: Don't spam console
@ECHO OFF

:: Current dir
SET CWD=%~dp0

:: Pick up ninja.exe and clang-format.exe
SET TOOLSDIR=%CWD%tools

:: Pickup extra tools like gendef, this isn't for gn-legacy itself
:: SET MINGW_PATH=%TOOLSDIR%\mingw\win\i686\bin

:: Add tools to path (and MinGW only when MINGW_PATH is set)
IF DEFINED MINGW_PATH (
  SET PATH=%TOOLSDIR%;%MINGW_PATH%;%PATH%
) ELSE (
  SET PATH=%TOOLSDIR%;%PATH%
)

:: Run ninja
"%TOOLSDIR%\ninja.exe" %*
