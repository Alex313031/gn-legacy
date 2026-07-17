# This file is used to manage the dependencies of this GN repo. It is
# used by gclient to determine what version of each dependency to check out,
# and where.

# Currently, it is used to download the MinGW toolchain & clang-format to tools/, and sources in src/

# See the sample gclient file in the root of this repo (must be renamed to .gclient and put one directory ABOVE this).

# Paths in this file (deps + hook cwd) are relative to THIS DEPS file's
# directory (the repo root), not to the .gclient one level up. Required so the
# deps land inside the repo and the hook can find tools/ below.
use_relative_paths = True

# Uncomment for all git dependencies specified in this file to be in sync with git
# submodules (gitlinks). Not enabled for this repo. See gclient gitmodules --help.
#git_dependencies = 'SYNC'

# Custom Flags, can be overridden in .gclient "custom_vars" section.
vars = {
  # GN source repo version
  'gn_version': '45874dc95fe5cd16a2dface0819f28d64ca2a006',

  # Ninja source repo version
  'ninja_version': '8c9642aa6d339b0e3f5fcd13f7a9274f13e6424b',

  # MinGW source repo version
  'mingw_version': '49c0afe9fdf3d7cc91808c2bb6b1c3ae29c6fab7',

  # Whether to download sources used to build MinGW/GN/Ninja itself to tools/src
  'download_toolchain_sources': 'True',

  # Whether to download custom sources to src/
  'download_sources': 'False',
}

# Only these hosts are allowed for dependencies in this DEPS file.
allowed_hosts = [
  'github.com',
  'chromium.googlesource.com',
]

# Dependencies, including binaries needed for building, and optional sources
deps = {
  # Only download toolchain sources if download_toolchain_sources == True
  'tools/src/gn': {
    # Source code to gn (bare minimum to use this repo)
    'url': 'https://github.com/Alex313031/gn-xp.git' + '@' + Var('gn_version'),
    'condition': 'download_toolchain_sources',
  },
  'tools/src/ninja': {
    # Source code used to build ninja used by this repo
    'url': 'https://github.com/Alex313031/ninja-xp.git' + '@' + Var('ninja_version'),
    'condition': 'download_toolchain_sources',
  },
  'tools/src/mingw-build': {
    # Source code used to build the MinGW toolchain.
    'url': 'https://github.com/Alex313031/mingw-build.git' + '@' + Var('mingw_version'),
    'condition': 'download_toolchain_sources',
  },

  # Only download win32 sources if download_sources == True
  'src/gmp-ninja': {
    # GN/Ninja port of the GMP library, useful in it's own right and for testing advanced GN configs.
    'url': 'https://github.com/Alex313031/gmp-ninja.git' + '@' + '151bbbbf033e5479352b133b0e1eaee93d6b6fd8',
    'condition': 'download_sources',
  },
}

# Hooks run after gclient finishes syncing the deps above. With
# use_relative_paths = True their working directory is this repo's root, so
# 'tools/...' resolves correctly.
hooks = [
  {
    # Downloads prebuilt artifacts built from the three toolchain sources above.
    'name': 'Download GN, Ninja, and MinGW Toolchains',
    'pattern': '.',
    'action': ['bash', 'tools/download_toolchains.sh', '--all'],
  },
]
