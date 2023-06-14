@rem 
@rem PROJECT:   Mouri Internal Library Essentials
@rem FILE:      BuildFFmpeg.cmd
@rem PURPOSE:   Build FFmpeg via vcpkg
@rem 
@rem LICENSE:   The MIT License
@rem 
@rem DEVELOPER: MouriNaruto (KurikoMouri@outlook.jp)
@rem 

@setlocal
@echo off

rem Change to the current folder.
cd "%~dp0Mile.FFmpeg.Vcpkg"

rem Bootstrap vcpkg
call bootstrap-vcpkg.bat

rem Set features list
set FFmpegFeatures=aom,ass,avcodec,avdevice,avfilter,avformat,bzip2,dav1d
set FFmpegFeatures=%FFmpegFeatures%,fontconfig,freetype,fribidi,iconv,ilbc
set FFmpegFeatures=%FFmpegFeatures%,lzma,modplug,mp3lame,openh264,openjpeg
set FFmpegFeatures=%FFmpegFeatures%,opus,snappy,soxr,speex,srt,swresample
set FFmpegFeatures=%FFmpegFeatures%,swscale,theora,vorbis,vpx,webp,xml2,zlib
rem ,sdl2,opencl
rem NotAvailableInAllPlatform alsa,nvcodec,opengl,ssh,tensorflow,tesseract

rem OBS Studio nvenc,amf,libx264 
rem K-Lite w32threads,libopencore-amrnb,libopencore-amrwb,avisynth,gnutls,gmp

set VcpkgOptions= --overlay-triplets=..\Mile.FFmpeg.Vcpkg.ExtraTriplets

rem Build FFmpeg via vcpkg
vcpkg install %VcpkgOptions% ffmpeg[%FFmpegFeatures%]:x86-windows-static-release
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
vcpkg install %VcpkgOptions% ffmpeg[%FFmpegFeatures%]:x64-windows-static-release
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
vcpkg install %VcpkgOptions% ffmpeg[%FFmpegFeatures%]:arm64-windows-static-release
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

@endlocal