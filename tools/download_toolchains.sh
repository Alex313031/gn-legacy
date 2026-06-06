#!/bin/bash

# Copyright (c) 2026 Alex313031

YEL='\033[1;33m' # Yellow
CYA='\033[1;96m' # Cyan
RED='\033[1;31m' # Red
GRE='\033[1;32m' # Green
c0='\033[0;00m'  # Reset Text
bold='\033[1;37m' # Bold Text
underline='\033[4m' # Underline Text

# Error handling
yell() { echo -e "$0: $*" >&2; }
die()  { yell "${RED}$* ${c0}"; exit 1; }
try() { "$@" || die "${RED}Failed $*"; }

# Download $1 into directory $2, keeping the URL's basename as the filename.
# curl ships with both Linux and Git Bash on Windows, so one helper covers both.
Fetch() {
  try curl -fSL --retry 3 -o "${2}/$(basename "$1")" "$1"
}

SCRIPTNAME=$(basename "$0")
SCRIPTVER="1.0.3"

export HERE=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# One dir up
GN_ROOT="${HERE}/.."

TOOLS_PATH="${HERE}"

MINGW_LINUX_PATH="${TOOLS_PATH}/mingw/linux"
MINGW_WIN32_PATH="${TOOLS_PATH}/mingw/win"
TMP_DOWN_PATH="${HERE}/TMP_"

export PATH="${TOOLS_PATH}:$PATH"

# Edit below lines to update toolchains
GN_VER="2026.06"
NINJA_VER="v1.13.2"
MINGW_VER="20260606"

DownloadGNLinux() {
  printf "${GRE}Downloading GN Linux Binary Version ${GN_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/gn/releases/download/${GN_VER}/gn_linux_amd64.zip" "$TMP_DOWN_PATH"
  printf "${GRE}Unzipping Linux gn.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/gn_linux_amd64.zip" -d "${TOOLS_PATH}"
}

DownloadGNWindows() {
  printf "${GRE}Downloading GN Windows Binary Version ${GN_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/gn/releases/download/${GN_VER}/gn_win_amd64.zip" "$TMP_DOWN_PATH"
  printf "${GRE}Unzipping Windows gn.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/gn_win_amd64.zip" -d "${TOOLS_PATH}"
}

DownloadNinjaLinux() {
  printf "${GRE}Downloading Ninja Linux Binary Version ${NINJA_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/ninja-xp/releases/download/${NINJA_VER}/ninja_linux.zip" "$TMP_DOWN_PATH"
  printf "${GRE}Unzipping Linux ninja.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/ninja_linux.zip" -d "${TOOLS_PATH}"
}

DownloadNinjaWindows() {
  printf "${GRE}Downloading Ninja Windows Binary Version ${NINJA_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/ninja-xp/releases/download/${NINJA_VER}/ninja_win.zip" "$TMP_DOWN_PATH"
  printf "${GRE}Unzipping Windows ninja.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/ninja_win.zip" -d "${TOOLS_PATH}"
}

# Linux MinGW toolchains
DownloadMinGWLinux () {
  printf "${GRE}Downloading i586 Linux Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/mingw_linux_i586.zip" "$TMP_DOWN_PATH"
  
  printf "${GRE}Downloading i686 Linux Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/mingw_linux_i686.zip" "$TMP_DOWN_PATH"

  printf "${GRE}Downloading x86_64 Linux Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/mingw_linux_x64.zip" "$TMP_DOWN_PATH"

  # Unpack
  printf "${GRE}Unzipping Linux i586.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/mingw_linux_i586.zip" -d "${MINGW_LINUX_PATH}"
  printf "${GRE}Unzipping Linux i686.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/mingw_linux_i686.zip" -d "${MINGW_LINUX_PATH}"
  printf "${GRE}Unzipping Linux x64.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/mingw_linux_x64.zip" -d "${MINGW_LINUX_PATH}"
}

# Windows MinGW toolchains
DownloadMinGWWindows () {
  printf "${GRE}Downloading i586 Windows Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/win32-devkit/releases/download/${MINGW_VER}/mingw_win_i586.zip" "$TMP_DOWN_PATH"

  printf "${GRE}Downloading i686 Windows Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/win32-devkit/releases/download/${MINGW_VER}/mingw_win_i686.zip" "$TMP_DOWN_PATH"

  printf "${GRE}Downloading x86_64 Windows Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/win32-devkit/releases/download/${MINGW_VER}/mingw_win_x64.zip" "$TMP_DOWN_PATH"

  # Unpack
  printf "${GRE}Unzipping Windows i586.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/mingw_win_i586.zip" -d "${MINGW_WIN32_PATH}"
  printf "${GRE}Unzipping Windows i686.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/mingw_win_i686.zip" -d "${MINGW_WIN32_PATH}"
  printf "${GRE}Unzipping Windows x64.zip... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/mingw_win_x64.zip" -d "${MINGW_WIN32_PATH}"
}

show_help() {
  cat <<EOF
Usage:
  $SCRIPTNAME [options]

Options:
  -h, --help Show this help.
  --version  Show script version.
  --gn       Download GN binaries
  --ninja    Download Ninja binaries
  --mingw    Download MinGW Toolchains
  -a, --all  Download everything

EOF

  exit 0
}

show_version() {
  printf "\n $SCRIPTNAME Version $SCRIPTVER \n\n"
  exit 0
}

# Verify required tools are present before doing anything.
CheckDeps() {
  command -v curl >/dev/null 2>&1 || die "curl is required but not installed."
  command -v unzip >/dev/null 2>&1 || die "unzip is required but not installed."
}

# Cleanup
CleanUp() {
  rm -rfv "${TMP_DOWN_PATH}/" &&
  printf "${GRE}Done.${c0}\n"
  exit 0
}

RunDownloads() {
  CheckDeps
  OS_NAME=$(uname -s)
  mkdir -p "${TMP_DOWN_PATH}" &&
  case "$OS_NAME" in
    CYGWIN*|MINGW*|MSYS*)
      printf "${GRE}Running under a Windows-based environment (Cygwin/MinGW/MSYS).${c0}\n"
      if [ "$DOWNLOAD_GN" == "1" ]; then
        DownloadGNWindows
      fi
      if [ "$DOWNLOAD_NINJA" == "1" ]; then
        DownloadNinjaWindows
      fi
      if [ "$DOWNLOAD_MINGW" == "1" ]; then
        DownloadMinGWWindows
      fi
      CleanUp
      ;;
    Linux)
      printf "${GRE}Running under Linux.${c0}\n"
      if [ "$DOWNLOAD_GN" == "1" ]; then
        DownloadGNLinux
      fi
      if [ "$DOWNLOAD_NINJA" == "1" ]; then
        DownloadNinjaLinux
      fi
      if [ "$DOWNLOAD_MINGW" == "1" ]; then
        DownloadMinGWLinux
      fi
      CleanUp
      ;;
    Darwin)
      printf "${GRE}Running under macOS${c0}\n"
      die "MacOS is unsupported for now."
      ;;
    *)
      die "Running under an unknown OS: $OS_NAME"
      ;;
  esac
}

# Parse options: set flags here, dispatch once after the loop.
while :; do
  case $1 in
    -h|--help)
        show_help
        ;;
    --version)
        show_version
        ;;
    --gn)
        DOWNLOAD_GN=1
        ;;
    --ninja)
        DOWNLOAD_NINJA=1
        ;;
    --mingw)
        DOWNLOAD_MINGW=1
        ;;
    -a|--all)
        DOWNLOAD_GN=1
        DOWNLOAD_NINJA=1
        DOWNLOAD_MINGW=1
        ;;
    --)
        shift
        break
        ;;
    -?*)
        die "Unknown option '$1'"
        ;;
    *)
        break
        ;;
  esac
  shift
done

# Nothing selected? Show help.
if [ -z "${DOWNLOAD_GN}${DOWNLOAD_NINJA}${DOWNLOAD_MINGW}" ]; then
  show_help
fi

RunDownloads
