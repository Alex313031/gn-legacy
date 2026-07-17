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

# Edit below 3 lines to update toolchains
GN_VER="2026.07xp"
NINJA_VER="v1.13.2xp4"
MINGW_VER="20260717"

# Download $1 into directory $2, keeping the URL's basename as the filename.
# curl ships with both Linux and Git Bash on Windows, so one helper covers both.
# CURL_INSECURE is "-k" when --insecure is passed: old curl (e.g. Git Bash on XP)
# has a stale CA bundle and rejects GitHub's modern certs ("curl: (60) ... unable
# to get local issuer certificate"); -k skips TLS verification. OFF by default so
# modern hosts (and the gclient hook) stay verified.
CURL_INSECURE=""
Fetch() {
  try curl -fSL ${CURL_INSECURE} --retry 3 -o "${2}/$(basename "$1")" "$1"
}

SCRIPTNAME=$(basename "$0")
SCRIPTVER="1.0.8"

export HERE=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# One dir up
GN_ROOT="${HERE}/.."

TOOLS_PATH="${HERE}"

MINGW_LINUX_PATH="${TOOLS_PATH}/mingw/linux"
MINGW_WIN32_PATH="${TOOLS_PATH}/mingw/win"
TMP_DOWN_PATH="${HERE}/TMP_"

export PATH="${TOOLS_PATH}:$PATH"

# Artifact names to download/unpack
LINUX_GCC_I586="mingw_gcc_linux_i586.zip"
LINUX_GCC_I686="mingw_gcc_linux_i686.zip"
LINUX_GCC_X64="mingw_gcc_linux_x64.zip"
WIN_GCC_I586="mingw_gcc_win_i586.zip"
WIN_GCC_I686="mingw_gcc_win_i686.zip"
WIN_GCC_X64="mingw_gcc_win_x64.zip"
# LLVM
LINUX_LLVM_I586="mingw_llvm_linux_i586.zip"
LINUX_LLVM_I686="mingw_llvm_linux_i686.zip"
LINUX_LLVM_X64="mingw_llvm_linux_x64.zip"
WIN_LLVM_I586="mingw_llvm_win_i586.zip"
WIN_LLVM_I686="mingw_llvm_win_i686.zip"
WIN_LLVM_X64="mingw_llvm_win_x64.zip"
# GN / Ninja
GN_LINUX_X86="gn_linux_i386.zip"
GN_LINUX_X64="gn_linux.zip"
GN_WIN_X86="gn_win32.zip"
GN_WIN_X64="gn_win64.zip"
NINJA_LINUX_X86="ninja_linux_i386.zip"
NINJA_LINUX_X64="ninja_linux.zip"
NINJA_WIN_X86="ninja_win32.zip"
NINJA_WIN_X64="ninja_win64.zip"

DownloadGNLinux() {
  if [ "$DOWNLOAD_I386" == "1" ]; then
    printf "${GRE}Downloading GN Linux x86 Binary Version ${GN_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/gn-xp/releases/download/${GN_VER}/${GN_LINUX_X86}" "$TMP_DOWN_PATH"
    printf "${GRE}Unzipping ${GN_LINUX_X86}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${GN_LINUX_X86}" -d "${TOOLS_PATH}"
  else
    printf "${GRE}Downloading GN Linux x64 Binary Version ${GN_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/gn-xp/releases/download/${GN_VER}/${GN_LINUX_X64}" "$TMP_DOWN_PATH"
    printf "${GRE}Unzipping ${GN_LINUX_X64}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${GN_LINUX_X64}" -d "${TOOLS_PATH}"
  fi
}

DownloadGNWindows() {
  if [ "$DOWNLOAD_I386" == "1" ]; then
    printf "${GRE}Downloading GN Windows x86 Binary Version ${GN_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/gn-xp/releases/download/${GN_VER}/${GN_WIN_X86}" "$TMP_DOWN_PATH"
    printf "${GRE}Unzipping ${GN_WIN_X86}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${GN_WIN_X86}" -d "${TOOLS_PATH}"
  else
    printf "${GRE}Downloading GN Windows x64 Binary Version ${GN_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/gn-xp/releases/download/${GN_VER}/${GN_WIN_X64}" "$TMP_DOWN_PATH"
    printf "${GRE}Unzipping ${GN_WIN_X64}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${GN_WIN_X64}" -d "${TOOLS_PATH}"
  fi
}

DownloadNinjaLinux() {
  if [ "$DOWNLOAD_I386" == "1" ]; then
    printf "${GRE}Downloading Ninja Linux x86 Binary Version ${NINJA_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/ninja-xp/releases/download/${NINJA_VER}/${NINJA_LINUX_X86}" "$TMP_DOWN_PATH"
    printf "${GRE}Unzipping ${NINJA_LINUX_X86}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${NINJA_LINUX_X86}" -d "${TOOLS_PATH}"
  else
    printf "${GRE}Downloading Ninja Linux x64 Binary Version ${NINJA_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/ninja-xp/releases/download/${NINJA_VER}/${NINJA_LINUX_X64}" "$TMP_DOWN_PATH"
    printf "${GRE}Unzipping ${NINJA_LINUX_X64}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${NINJA_LINUX_X64}" -d "${TOOLS_PATH}"
  fi
}

DownloadNinjaWindows() {
  if [ "$DOWNLOAD_I386" == "1" ]; then
    printf "${GRE}Downloading Ninja Windows x86 Binary Version ${NINJA_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/ninja-xp/releases/download/${NINJA_VER}/${NINJA_WIN_X86}" "$TMP_DOWN_PATH"
    printf "${GRE}Unzipping ${NINJA_WIN_X86}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${NINJA_WIN_X86}" -d "${TOOLS_PATH}"
  else
    printf "${GRE}Downloading Ninja Windows x64 Binary Version ${NINJA_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/ninja-xp/releases/download/${NINJA_VER}/${NINJA_WIN_X64}" "$TMP_DOWN_PATH"
    printf "${GRE}Unzipping ${NINJA_WIN_X64}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${NINJA_WIN_X64}" -d "${TOOLS_PATH}"
  fi
}

# Linux MinGW toolchains
DownloadMinGWLinux () {
  # First MinGW/GCC Toolchains
  printf "${GRE}Downloading i586 Linux GCC Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${LINUX_GCC_I586}" "$TMP_DOWN_PATH"
  
  printf "${GRE}Downloading i686 Linux GCC Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${LINUX_GCC_I686}" "$TMP_DOWN_PATH"

  if [ ! "$DOWNLOAD_I386" ]; then
    printf "${GRE}Downloading x64 Linux GCC Toolchain version ${MINGW_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${LINUX_GCC_X64}" "$TMP_DOWN_PATH"
  fi
  # Then MinGW/LLVM toolchains
  if [ ! "$SKIP_LLVM" ]; then
    printf "${GRE}Downloading i586 Linux LLVM Toolchain version ${MINGW_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${LINUX_LLVM_I586}" "$TMP_DOWN_PATH"

    printf "${GRE}Downloading i686 Linux LLVM Toolchain version ${MINGW_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${LINUX_LLVM_I686}" "$TMP_DOWN_PATH"

    if [ ! "$DOWNLOAD_I386" ]; then
      printf "${GRE}Downloading x64 Linux LLVM Toolchain version ${MINGW_VER} ${c0}\n"
      Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${LINUX_LLVM_X64}" "$TMP_DOWN_PATH"
    fi
  fi

  # Unpack zips
  printf "${GRE}Unzipping ${LINUX_GCC_I586}... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/${LINUX_GCC_I586}" -d "${MINGW_LINUX_PATH}"
  printf "${GRE}Unzipping ${LINUX_GCC_I686}... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/${LINUX_GCC_I686}" -d "${MINGW_LINUX_PATH}"
  if [ ! "$DOWNLOAD_I386" ]; then
    printf "${GRE}Unzipping ${LINUX_GCC_X64}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${LINUX_GCC_X64}" -d "${MINGW_LINUX_PATH}"
  fi
  # LLVM zips
  if [ ! "$SKIP_LLVM" ]; then
    printf "${GRE}Unzipping ${LINUX_LLVM_I586}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${LINUX_LLVM_I586}" -d "${MINGW_LINUX_PATH}"
    printf "${GRE}Unzipping ${LINUX_LLVM_I686}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${LINUX_LLVM_I686}" -d "${MINGW_LINUX_PATH}"
    if [ ! "$DOWNLOAD_I386" ]; then
      printf "${GRE}Unzipping ${LINUX_LLVM_X64}... ${c0}\n"
      try unzip -o "$TMP_DOWN_PATH/${LINUX_LLVM_X64}" -d "${MINGW_LINUX_PATH}"
    fi
  fi
}

# Windows MinGW toolchains
DownloadMinGWWindows () {
  printf "${GRE}Downloading i586 Windows GCC Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${WIN_GCC_I586}" "$TMP_DOWN_PATH"

  printf "${GRE}Downloading i686 Windows GCC Toolchain version ${MINGW_VER} ${c0}\n"
  Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${WIN_GCC_I686}" "$TMP_DOWN_PATH"

  if [ ! "$DOWNLOAD_I386" ]; then
    printf "${GRE}Downloading x64 Windows GCC Toolchain version ${MINGW_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${WIN_GCC_X64}" "$TMP_DOWN_PATH"
  fi
  # Then MinGW/LLVM toolchains
  if [ ! "$SKIP_LLVM" ]; then
    printf "${GRE}Downloading i586 Windows LLVM Toolchain version ${MINGW_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${WIN_LLVM_I586}" "$TMP_DOWN_PATH"

    printf "${GRE}Downloading i686 Windows LLVM Toolchain version ${MINGW_VER} ${c0}\n"
    Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${WIN_LLVM_I686}" "$TMP_DOWN_PATH"

    if [ ! "$DOWNLOAD_I386" ]; then
      printf "${GRE}Downloading x64 Windows LLVM Toolchain version ${MINGW_VER} ${c0}\n"
      Fetch "https://github.com/Alex313031/mingw-build/releases/download/${MINGW_VER}/${WIN_LLVM_X64}" "$TMP_DOWN_PATH"
    fi
  fi

  # Unpack zips
  printf "${GRE}Unzipping ${WIN_GCC_I586}... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/${WIN_GCC_I586}" -d "${MINGW_WIN32_PATH}"
  printf "${GRE}Unzipping ${WIN_GCC_I686}... ${c0}\n"
  try unzip -o "$TMP_DOWN_PATH/${WIN_GCC_I686}" -d "${MINGW_WIN32_PATH}"
  if [ ! "$DOWNLOAD_I386" ]; then
    printf "${GRE}Unzipping ${WIN_GCC_X64}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${WIN_GCC_X64}" -d "${MINGW_WIN32_PATH}"
  fi
  # LLVM zips
  if [ ! "$SKIP_LLVM" ]; then
    printf "${GRE}Unzipping ${WIN_LLVM_I586}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${WIN_LLVM_I586}" -d "${MINGW_WIN32_PATH}"
    printf "${GRE}Unzipping ${WIN_LLVM_I686}... ${c0}\n"
    try unzip -o "$TMP_DOWN_PATH/${WIN_LLVM_I686}" -d "${MINGW_WIN32_PATH}"
    if [ ! "$DOWNLOAD_I386" ]; then
      printf "${GRE}Unzipping ${WIN_LLVM_X64}... ${c0}\n"
      try unzip -o "$TMP_DOWN_PATH/${WIN_LLVM_X64}" -d "${MINGW_WIN32_PATH}"
    fi
  fi
}

show_help() {
  cat <<EOF
Usage:
  $SCRIPTNAME [options]

Options:
  -h, --help Show this help.
  --version  Show script version.
  --i386     Download 32 Bit binaries instead of 64 Bit (XP compatible!).
  --insecure Skip TLS cert verification (for old curl).
  --gn       Download GN binaries.
  --ninja    Download Ninja binaries.
  --mingw    Download MinGW Toolchains.
  --no-llvm  Skip LLVM MinGW toolchains and only download GCC ones.
  -xp, --xp  Convenience flag for Win XP (equivalent to --all --i386 --insecure).
  -a, --all  Download everything (respects --no-llvm and --i386).

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
    --no-llvm)
        SKIP_LLVM=1
        ;;
    --i386)
        DOWNLOAD_I386=1
        ;;
    --insecure)
        CURL_INSECURE="-k"
        ;;
    -a|--all)
        DOWNLOAD_GN=1
        DOWNLOAD_NINJA=1
        DOWNLOAD_MINGW=1
        ;;
    -xp|--xp)
        DOWNLOAD_GN=1
        DOWNLOAD_NINJA=1
        DOWNLOAD_MINGW=1
        DOWNLOAD_I386=1
        CURL_INSECURE="-k"
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
