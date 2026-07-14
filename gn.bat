:: Copyright (c) 2026 Alex313031

:: Windows gn wrapper for GN-Legacy

:: Don't spam console
@ECHO OFF

:: Current dir
SET CWD=%~dp0

:: Pick up gn.exe
SET TOOLSDIR=%CWD%tools

:: Run gn.exe
"%TOOLSDIR%\gn.exe" %*
