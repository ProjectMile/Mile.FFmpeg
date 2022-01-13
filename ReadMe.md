﻿# Mile.FFmpeg

[Total Downloads](https://img.shields.io/github/downloads/ProjectMile/Mile.FFmpeg/total)
[![GitHub Releases](https://img.shields.io/github/v/release/ProjectMile/Mile.FFmpeg?include_prereleases)](https://github.com/ProjectMile/Mile.FFmpeg/releases)
[![NuGet Package](https://img.shields.io/nuget/vpre/Mile.FFmpeg)](https://www.nuget.org/packages/Mile.FFmpeg)

## Features

- Based on the latest FFmpeg source code tree from vcpkg.
- Compile FFmpeg and related third-party libraries via vcpkg with avcodec, 
  avdevice, avfilter, avformat, avresample, bzip2, iconv, lzma, modplug, 
  mp3lame, openh264, openjpeg, opus, snappy, soxr, speex, swresample, swscale,
  theora, vorbis, webp, xml2 and zlib enabled.
- Use [VC-LTL 5.x](https://github.com/Chuyu-Team/VC-LTL5) toolchain to make the
  binary size smaller.
- Provide NuGet package.

## System Requirements

- Supported OS: Windows Vista RTM or later
- Supported Platforms: x86, x86-64(AMD64), ARM and ARM64.

# Documents

- [License](License.md)
- [Release Notes](ReleaseNotes.md)