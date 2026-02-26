:: Copyright (c) 2026 Alex313031

@ECHO OFF

ECHO NINJA 64 Bit

SET CWD=%~dp0

SET TOOLSDIR=%CWD%\tools

SET MINGW_PATH=%TOOLSDIR%\mingw\win\x64\bin

SET PATH=%TOOLSDIR%;%PATH%

%TOOLSDIR%\ninja.exe %*
