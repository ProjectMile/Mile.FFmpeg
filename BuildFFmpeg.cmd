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
set FFmpegFeatures=aom,avcodec,avdevice,avfilter,avformat,bzip2,dav1d
set FFmpegFeatures=%FFmpegFeatures%,fontconfig,freetype,iconv,ilbc,lzma,modplug
set FFmpegFeatures=%FFmpegFeatures%,mp3lame,openh264,openjpeg,opus,snappy,soxr
set FFmpegFeatures=%FFmpegFeatures%,speex,srt,swresample,swscale,theora,vorbis
set FFmpegFeatures=%FFmpegFeatures%,vpx,webp,xml2,zlib
rem ,sdl2,opencl
rem NotAvailableInAllPlatform alsa,ass,fribidi,nvcodec,opengl,ssh,tensorflow,tesseract

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