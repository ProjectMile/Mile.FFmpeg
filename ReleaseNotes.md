﻿# Mile.FFmpeg Release Notes

**Mile.FFmpeg 6.1.0.0**

- Upgrade FFmpeg to 6.1.
- Update vcpkg to 2023.11.20 release.
- Extend the NuGet package platform support.

**Mile.FFmpeg 6.0.0.0**

- Upgrade FFmpeg to 6.0.
- Update vcpkg to 2023.10.19 release.
- Update to the newest of Mile.Project.Helpers.
- Remove ARM32 target support.
- Simplify the build script logic.

**Mile.FFmpeg 5.1.2.0**

- Upgrade FFmpeg to 5.1.2.
- Start to use mainline vcpkg as Mile.FFmpeg.Vcpkg submodule.
- Update to Git submodule version of Mile.Project.Windows.

**Mile.FFmpeg 5.0.1.0**

- Upgrade FFmpeg to 5.0.1.

**Mile.FFmpeg 5.0.0.2**

- Integrate ass and fribidi support.

**Mile.FFmpeg 5.0.0.1**

- Split the symbol files to standalone package.
- Integrate aom and ilbc support.

**Mile.FFmpeg 5.0.0.0**

- Upgrade FFmpeg to 5.0.
- Migrate from vcpkg to Mile.FFmpeg.Vcpkg.
- Integrate dav1d, srt and vpx support.

**Mile.FFmpeg 4.4.1.1**

- Fix issue which you can't use Mile.FFmpeg.
- Integrate fontconfig and freetype support.
- Add documents for the whole project.
- Provide package for using without NuGet.

**Mile.FFmpeg 4.4.1.0**

- Based on FFmpeg 4.4.1 source code tree.
- Compile FFmpeg and related third-party libraries via vcpkg with avcodec, 
  avdevice, avfilter, avformat, avresample, bzip2, iconv, lzma, modplug, 
  mp3lame, openh264, openjpeg, snappy, soxr, speex, opus, swresample, swscale,
  theora, vorbis, webp, xml2 and zlib enabled.
- Use [VC-LTL 5.x](https://github.com/Chuyu-Team/VC-LTL5) toolchain to make the
  binary size smaller.
- Provide NuGet package.
