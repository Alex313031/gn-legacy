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

wget -P $TMP_DOWN_PATH https://github.com/Alex313031/mingw-linux-build/releases/download/20260209/i686.zip &&
wget -P $TMP_DOWN_PATH https://github.com/Alex313031/mingw-linux-build/releases/download/20260209/x64.zip &&

unzip $TMP_DOWN_PATH/i686.zip -d ${MINGW_LINUX_PATH} &&
unzip $TMP_DOWN_PATH/x64.zip -d ${MINGW_LINUX_PATH} &&

rm -rfv ${TMP_DOWN_PATH}/*

exit 0
