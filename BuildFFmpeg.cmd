@rem 
@rem PROJECT:   Mouri Internal Library Essentials
@rem FILE:      BuildFFmpeg.cmd
@rem PURPOSE:   Build FFmpeg via vcpkg
@rem 
@rem LICENSE:   The MIT License
@rem 
@rem DEVELOPER: Mouri_Naruto (Mouri_Naruto AT Outlook.com)
@rem 

@setlocal
@echo off

rem Change to the current folder.
cd "%~dp0Mile.FFmpeg.Vcpkg"

rem Bootstrap vcpkg
call bootstrap-vcpkg.bat

rem Set features list
set FFmpegFeatures=avcodec,avdevice,avfilter,avformat,bzip2,dav1d,fontconfig
set FFmpegFeatures=%FFmpegFeatures%,freetype,iconv,lzma,modplug,mp3lame
set FFmpegFeatures=%FFmpegFeatures%,openh264,openjpeg,snappy,soxr,speex,opus
set FFmpegFeatures=%FFmpegFeatures%,srt,swresample,swscale,theora,vorbis,vpx
set FFmpegFeatures=%FFmpegFeatures%,webp,xml2,zlib
rem ,sdl2,opencl
rem NotAvailableInAllPlatform alsa,aom,ass,fribidi,ilbc,nvcodec,opengl,ssh,tensorflow,tesseract

rem OBS Studio nvenc,amf,libx264 
rem K-Lite w32threads,libopencore-amrnb,libopencore-amrwb,avisynth,gnutls,gmp

rem Build FFmpeg via vcpkg
vcpkg install ffmpeg[%FFmpegFeatures%]:x86-windows-static
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
vcpkg install ffmpeg[%FFmpegFeatures%]:x64-windows-static
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
vcpkg install ffmpeg[%FFmpegFeatures%]:arm-windows-static
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
vcpkg install ffmpeg[%FFmpegFeatures%]:arm64-windows-static 
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

@endlocal