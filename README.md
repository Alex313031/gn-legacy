# GN Legacy

#### Simple GN Build Toolchain Boilerplate for Legacy Win32.

It is the [GN](https://gn.googlesource.com/gn/) + [Ninja](https://ninja-build.org/) build system that [Chromium](https://www.chromium.org/) uses,
but minified and specifically designed for building C/C++ apps targeting legacy versions of Windows.

### Motivation
GN Legacy is specifically designed for targeting Windows 2000 - Windows 8.1. This makes building small or large C/C++ projects
faster and easier than any method besides Makefiles. Makefiles don't have the cross
platform extensibility that GN provides, or the compilation speed that Ninja provides, however.

Existing projects that aim to simplify Win32 build toolchains often can't target anything older than Windows 7,
that's where this project comes in.

It is based on the example simple GN build structure in the GN repo [Here](https://gn.googlesource.com/gn/+/refs/heads/main/examples/simple_build/).  
It is deliberately simplistic so the structure is more clear, and doesn't support everything on
every platform. It has minimal support for Linux, but almost all support is for Windows.  
My CryoCalc project is added as a Git submodule in [./src/cryocalc](https://github.com/Alex313031/cryocalc#readme) as an example app.  

## Getting Started

#### Prerequisites:
  This toolchain requires `git`, `unzip`, and `wget` (Git for Windows has unzip, this repo has wget.exe in ./tools).  
  For Debian based distros: `sudo apt install --needed git unzip wget`.
  On Windows, just install [Git for Windows](https://git-scm.com/install/windows) has unzip, this repo has wget.exe in ./tools)

#### Initial Setup

First, clone the repo (use `--recursive` to clone the CryoCalc example app submodule):

```bash
git clone --recursive https://github.com/Alex313031/gn-legacy.git
```

Then, we need to add some directories to our path so we can use the Ninja, GN, wget, and MinGW binaries in `./tools`:

```bash
# (From Linux Terminal or Git Bash if on Windows)

cd gn-legacy &&

. set_env_vars.sh

# or for targeting Win x64:

. set_env_vars64.sh
```

Then, we need to download the MinGW toolchains (See [About the Compiler](#about-the-compiler)). I host pre-built .zips of both the Windows and Linux (for cross-building) toolchains for x86/x64.  
The script `download_toolchains.sh` will automatically detect whether you are on Linux or Windows and download the appropriate toolchains. It uses wget, so make sure you have it installed if on linux, for win
a `wget.exe` binary is in the [./tools/](./tools/) directory for convenience. However, they could also be built and unpacked yourself, if you don't trust my prebuilt .zips.

```bash
# (From Git Bash if on Windows)

./download_toolchains.sh
```

#### Building Programs
Now that we have downloaded the toolchains, we can start building some apps!  
Building can be done from bash or cmd.exe. Using GN (which stands for "Generate Ninja"), we generate *.ninja* files that
Ninja can use to run the correct commands to compile your app(s).

This repo uses forks I made of each, again to support legacy Windows: https://github.com/Alex313031/gn & https://github.com/Alex313031/ninja-xp.

First, choose your build arguments, (the "args"), and generate a build output directory for Ninja using GN:

```bash
# Must be subdir of "out", can be named whatever you like

./gn args out/Debug

# or in cmd.exe

gn.bat args out\Release
```
 A text editor will pop up, editing *out/$BUILDDIR/args.gn*, and here is where you set build arguments, such as target windows version, C++ standard, debug/release mode, etc.

Two sample *args.gn* files are provided to get up and running quickly, with comments explaining what the args do. Depending on whether you want a debug or release build,
choose either the [release_args.gn](./release_args.gn) or [debug_args.gn](./debug_args.gn) file. Copy the contents and paste it into the text editor, or type your own custom args now.

Next, build it!  
Ninja will read the .ninja files generated in the previous step, and then invoke
the compiler and append the flags/directories needed to compile sources, according to configurations in [./build/](./build/):

```bash
# You can append the flag `-j#` at the end, where "#" is the number of jobs, for multi-threaded compile.
# You can append the flag `-v` at the end, to show verbose compilation logs.

./ninja -C out/build all -j4 # Build with 4 CPU cores

# or in cmd.exe

ninja.bat -C out\build all -v # Log each build step
```

You can also clean a build output directory (equivalent to running `make clean`) like so:

```bash
./ninja -C out/build -t clean

# or in cmd.exe

ninja.bat -C out\build -t clean
```
 Your `.exe`/`.dll`/`.a` files should be in *out/build* (or whatever you named your build output directory).

#### Adding your own sources

Projects use *BUILD.gn* files in place of a `Makefile` or `.vcxproj` file. A BUILD.gn file describes the sources, configs, and project-specific
defines or compilation flags. They are hierarchical by design, and can depend on one another.  
Targets should be added as a subdirectory of `./src/`, and the target added to the [main BUILD.gn](./src/BUILD.gn) in `./src/BUILD.gn`.

See the [./test/win/BUILD.gn](./test/win/BUILD.gn) for a good example on making an .exe, .dll, and static .lib using inter-dependant *BUILD.gn* files.  
For more help, see [Resources](#resources).

### About the Compiler
It uses a custom [MinGW](https://www.mingw-w64.org/) toolchain + [GCC](https://gcc.gnu.org/) + [patches](https://github.com/Alex313031/mingw-linux-build/tree/master/patches)
and compiler configs to allow targeting all the way back to Windows 2000.  
On Linux it uses [my fork](https://github.com/Alex313031/mingw-linux-build) of [mingw-w64-build](https://github.com/Zeranoe/mingw-w64-build),
on Windows it uses [my fork](https://github.com/Alex313031/win32-devkit) of [w64devkit](https://github.com/skeeto/w64devkit).  

### Resources

GN Quick Start Guide: https://github.com/Alex313031/gn/blob/master/docs/quick_start.md (Has Chromium-specific stuff in there, but still helpful)

GN Reference: https://github.com/Alex313031/gn/blob/master/docs/reference.md (How to use/write BUILD.gn files)

Ninja Manual: https://github.com/Alex313031/ninja-xp/blob/release/doc/manual.asciidoc (Markdown version of [Upstream Manual](https://ninja-build.org/manual.html))

### Acknowledgments

[Tim Niederhausen](https://github.com/timniederhausen) for his forks of GN and Ninja, which mine are based on.

[Christopher Wellons](https://github.com/skeeto) for showing me how to compile MinGW targeting old Windows.

[Chromium Team](https://source.chromium.org/chromium/chromium/src/+/main:AUTHORS) for these projects in the first place.
