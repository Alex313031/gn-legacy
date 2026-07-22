#!/bin/bash

# Copyright (c) 2026 Alex313031

# Formats the repo's GN files (build/, test/, and the root BUILD.gn and .gn)
# with the local gn binary. Can be run from anywhere; paths resolve relative
# to the repo root. src/ is left alone on purpose, so each project controls
# its own formatting.

# Colors
YEL='\033[1;33m'  # Yellow
CYA='\033[1;96m'  # Cyan
RED='\033[1;31m'  # Red
GRE='\033[1;32m'  # Green
C0='\033[0;00m'   # Reset Text
BOLD='\033[1;37m' # Bold Text
ULINE='\033[4m'   # Underline Text

# Error handling
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "${RED}Failed $*"; }

# Where this script lives
export HERE=$(cd "$(dirname "$0")" && pwd) &&

# Go up one directory to the repo root, and run git/gn from there
export REPO_ROOT=$(dirname "${HERE}") &&
cd "${REPO_ROOT}" &&

# List the .gn/.gni files to be formatted: tracked plus new (not ignored)
# files. NOTE: the unquoted ${REPO_FILES} below relies on word splitting;
# paths in this repo contain no spaces.
export REPO_FILES=$(git ls-files -co --exclude-standard -- build test BUILD.gn .gn | grep -E '\.gni?$')

if [ -z "${REPO_FILES}" ]; then
  printf "No GN files found to format.\n"
  exit 1
fi

printf "${GRE}Formatting: \n ${BOLD}%s${C0}\n\n" "${REPO_FILES}" &&

# Run local gn format
try ./tools/gn format -v ${REPO_FILES} &&

printf "\n${GRE}Done \n"
