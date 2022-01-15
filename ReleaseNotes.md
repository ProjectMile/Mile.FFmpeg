# Mile.FFmpeg Release Notes

**Mile.FFmpeg 4.4.1.1**

- Fix issue which you can't use Mile.FFmpeg.
- Integrate fontconfig and freetype support.
- Add debug libraries in the NuGet package.
- Add documents for the whole project.

**Mile.FFmpeg 4.4.1.0**

- Based on FFmpeg 4.4.1 source code tree.
- Compile FFmpeg and related third-party libraries via vcpkg with avcodec, 
  avdevice, avfilter, avformat, avresample, bzip2, iconv, lzma, modplug, 
  mp3lame, openh264, openjpeg, snappy, soxr, speex, opus, swresample, swscale,
  theora, vorbis, webp, xml2 and zlib enabled.
- Use [VC-LTL 5.x](https://github.com/Chuyu-Team/VC-LTL5) toolchain to make the
  binary size smaller.
- Provide NuGet package.
