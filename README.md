# GN-Legacy

#### A GN Build Toolchain for Legacy Windows (and Linux).

This is the [GN](https://gn.googlesource.com/gn/) + [Ninja](https://ninja-build.org/) build system that [Chromium](https://www.chromium.org/) uses,
but minimal and specifically designed for building C/C++ apps targeting legacy versions of Windows.  
In addition, the toolchain supports *running* on legacy Windows (down to XP).

<table>
  <tr>
    <td align="center" valign="middle"><img src="./assets/WinNT4Workstation_Logo.svg" height="64"></td>
    <td align="center" valign="middle"><img src="./assets/Win2000_Logo.svg" height="64"></td>
    <td align="center" valign="middle"><img src="./assets/WinXP_Logo.svg" height="64"></td>
    <td align="center" valign="middle"><img src="./assets/WinVista_Orb.svg" height="64"></td>
  </tr>
</table>

## Usage

See [the docs directory](./docs/README.md).

## Motivation
GN-Legacy was built from the ground up for targeting legacy Windows (i.e. NT 4.0, 2000, XP, Vista, 7), but it can target modern Windows too.  
It makes building small or large C/C++ projects faster and easier. Makefiles don't have the cross
platform extensibility that GN provides, or the compilation speed that Ninja provides. I found existing
toolchains impractical, or they straight up don't work.

Existing projects that aim to simplify Win32 build toolchains often can't target anything older
than Windows 7 (Modern MSVC for example), or they are incomplete/hard to use. That's where this project comes in. There is
a small learning curve getting used to how GN works and how to write BUILD.gn files, but once you learn it, I feel almost
every C/C++ dev can appreciate what the build system has to offer.

### Acknowledgments

[Tim Niederhausen](https://github.com/timniederhausen) for his forks GN ([Here](https://github.com/timniederhausen/gn)), and Ninja ([Here](https://github.com/timniederhausen/ninja)), which mine are based on.
I also initially based this repo on his [gn-build repo](https://github.com/timniederhausen/gn-build), but found it too like Chromium's and too tied to Visual Studio.

[Christopher Wellons](https://github.com/skeeto) for showing me how to compile MinGW targeting old Windows. His [w64devkit](https://github.com/skeeto/w64devkit) is a good alternative to this toolchain,
it provides a bash shell with Make, Ninja, MinGW, busybox, and [NSIS](https://nsis.sourceforge.io/Main_Page), that supports Windows XP.

[Will](https://github.com/mon/llvm-mingw-xp/tree/master/patches) and [iProgramInCpp](https://github.com/DiscordMessenger/dm/tree/master/doc/pentium-toolchain) for additional patches
that I found useful in making the compiler toolchains for this repo.

[Chromium Team](https://source.chromium.org/chromium/chromium/src/+/main:AUTHORS) for these projects in the first place. (Fun fact, I'm in that file)

### License
This repository is licensed under the [BSD 3-Clause License](./LICENSE.md).
