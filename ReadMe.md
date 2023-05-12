# Mile.FFmpeg

![Total Downloads](https://img.shields.io/github/downloads/ProjectMile/Mile.FFmpeg/total)
[![GitHub Releases](https://img.shields.io/github/v/release/ProjectMile/Mile.FFmpeg?include_prereleases)](https://github.com/ProjectMile/Mile.FFmpeg/releases)
[![NuGet Package](https://img.shields.io/nuget/vpre/Mile.FFmpeg)](https://www.nuget.org/packages/Mile.FFmpeg)

Mile.FFmpeg is the merged FFmpeg dynamic linked library for the Windows.

## Features

- Based on the latest FFmpeg source code tree from vcpkg.
- Compile FFmpeg and related third-party libraries via vcpkg with aom, ass, 
  avcodec, avdevice, avfilter, avformat, bzip2, dav1d, fontconfig, freetype, 
  fribidi, iconv, ilbc, lzma, modplug, mp3lame, openh264, openjpeg, opus, 
  snappy, soxr, speex, srt, swresample, swscale, theora, vorbis, vpx, webp, 
  xml2 and zlib enabled.
- Use [VC-LTL 5.x](https://github.com/Chuyu-Team/VC-LTL5) toolchain to make the
  binary size smaller.
- Provide NuGet package.

## Usage

You only need to search and add `Mile.FFmpeg` package in your NuGet client or 
download packages in 
[GitHub Releases](https://github.com/ProjectMile/Mile.FFmpeg/releases) if you
don't want to use NuGet package manager.

## System Requirements

- Supported OS: Windows Vista RTM or later
- Supported Platforms: x86, x86-64(AMD64) and ARM64

## Documents

- [License](https://github.com/ProjectMile/Mile.FFmpeg/blob/main/License.md)
- [Release Notes](https://github.com/ProjectMile/Mile.FFmpeg/blob/main/ReleaseNotes.md)
