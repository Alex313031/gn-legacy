:: Copyright (c) 2026 Alex313031

@ECHO OFF

ECHO NINJA 64 Bit

SET CWD=%~dp0

SET TOOLSDIR=%CWD%\tools

SET PATH=%TOOLSDIR%\mingw\win\x64\bin;%PATH%

%TOOLSDIR%\ninja.exe %*
