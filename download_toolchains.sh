#!/bin/bash

# Copyright (c) 2026 Alex313031

YEL='\033[1;33m' # Yellow
CYA='\033[1;96m' # Cyan
RED='\033[1;31m' # Red
GRE='\033[1;32m' # Green
c0='\033[0m' # Reset Text
bold='\033[1m' # Bold Text
underline='\033[4m' # Underline Text

# Error handling
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "${RED}Failed $*"; }

export HERE=${PWD} &&
export TOOLS_PATH=${HERE}/tools &&
export MINGW_LINUX_PATH=${TOOLS_PATH}/mingw/linux &&
export MINGW_WIN32_PATH=${TOOLS_PATH}/mingw/win &&
export TMP_DOWN_PATH=${HERE}/TMP_ &&

export PATH=${TOOLS_PATH}:$PATH

# Linux toolchain
DownloadLinux () {
  printf "${GRE}Downloading 32 bit Linux Toolchain... ${c0}\n" &&
  wget -P $TMP_DOWN_PATH https://github.com/Alex313031/mingw-linux-build/releases/download/20260221/i686.zip &&
  printf "${GRE}Unzipping Linux i686.zip... ${c0}\n" &&
  unzip $TMP_DOWN_PATH/i686.zip -d ${MINGW_LINUX_PATH} &&

  printf "${GRE}Downloading 64 bit Linux Toolchain... ${c0}\n" &&
  wget -P $TMP_DOWN_PATH https://github.com/Alex313031/mingw-linux-build/releases/download/20260221/x64.zip &&
  printf "${GRE}Unzipping Linux x64.zip... ${c0}\n" &&
  unzip $TMP_DOWN_PATH/x64.zip -d ${MINGW_LINUX_PATH} &&

  rm -rfv ${TMP_DOWN_PATH}/
}

# Windows toolchain
DownloadWindows () {
  printf "${GRE}Downloading 32 bit Windows Toolchain... ${c0}\n" &&
  wget.exe -P $TMP_DOWN_PATH https://github.com/Alex313031/win32-devkit/releases/download/v2.5.1/i686.zip &&
  printf "${GRE}Unzipping Windows i686.zip... ${c0}\n" &&
  unzip $TMP_DOWN_PATH/i686.zip -d ${MINGW_WIN32_PATH} &&

  printf "${GRE}Downloading 64 bit Windows Toolchain... ${c0}\n" &&
  wget.exe -P $TMP_DOWN_PATH https://github.com/Alex313031/win32-devkit/releases/download/v2.5.1/x64.zip &&
  printf "${GRE}Unzipping Windows x64.zip... ${c0}\n" &&
  unzip $TMP_DOWN_PATH/x64.zip -d ${MINGW_WIN32_PATH} &&

  rm -rfv ${TMP_DOWN_PATH}/
}

# MacOS (none yet)
DownloadMacOS () {
  printf "${RED}...not downloading for MacOS, no builds yet.${c0}\n"
}

OS_NAME=$(uname -s)

case "$OS_NAME" in
  CYGWIN*|MINGW*|MSYS*)
    printf "${GRE}Running under a Windows-based environment (Cygwin/MinGW/MSYS).${c0}\n" &&
      DownloadWindows;
    ;;
  Linux)
    printf "${GRE}Running under Linux.${c0}\n" &&
      DownloadLinux;
    ;;
  Darwin)
    printf "${GRE}Running under macOS${c0}\n" &&
      DownloadMac;
    ;;
  *)
    echo "Running under an unknown OS: $OS_NAME"
      DownloadLinux;
    ;;
esac

exit 0
