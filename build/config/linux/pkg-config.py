#!/usr/bin/env python3

# Copyright (c) 2026 Alex313031

"""Minimal pkg-config wrapper for GN's exec_script.

GN's exec_script() runs a script, not an arbitrary command, so this thin wrapper
shells out to pkg-config and prints one token per line. Callers parse the output
with the "list lines" conversion, turning it straight into a GN list suitable for
a config's cflags / libs / lib_dirs.

    Usage: pkg-config.py <mode> <pkg> [<pkg> ...]

    <mode> is one of:
      cflags    --cflags        as-is (-I / -D / -pthread ...) -> config cflags
      libs      --libs-only-l   with the leading -l stripped   -> config libs
      lib_dirs  --libs-only-L   with the leading -L stripped   -> config lib_dirs

GN's `libs` and `lib_dirs` want bare names/paths (the toolchain re-adds the
-l / -L switch), so those two modes strip the prefix; `cflags` is passed through
verbatim. A missing dev package makes pkg-config exit non-zero, which aborts
`gn gen` and surfaces pkg-config's own "No package '...' found" message.
"""

import subprocess
import sys

_MODES = {
    "cflags": "--cflags",
    "libs": "--libs-only-l",
    "lib_dirs": "--libs-only-L",
}


def main(argv):
    if len(argv) < 3 or argv[1] not in _MODES:
        sys.stderr.write(
            "usage: pkg-config.py <%s> <pkg>...\n" % "|".join(_MODES))
        return 2

    mode = argv[1]
    packages = argv[2:]

    try:
        out = subprocess.check_output(
            ["pkg-config", _MODES[mode]] + packages, universal_newlines=True)
    except OSError:
        sys.stderr.write("pkg-config.py: pkg-config is not installed or not on "
                         "PATH\n")
        return 1
    except subprocess.CalledProcessError as e:
        # pkg-config already printed why (e.g. the package is not installed).
        return e.returncode

    strip = {"libs": "-l", "lib_dirs": "-L"}.get(mode)
    for token in out.split():
        if strip and token.startswith(strip):
            token = token[len(strip):]
        print(token)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
