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
set FFmpegFeatures=avcodec,avdevice,avfilter,avformat,avresample,bzip2
set FFmpegFeatures=%FFmpegFeatures%,fontconfig,freetype,iconv,lzma,modplug
set FFmpegFeatures=%FFmpegFeatures%,mp3lame,openh264,openjpeg,snappy,soxr
set FFmpegFeatures=%FFmpegFeatures%,speex,opus,swresample,swscale,theora
set FFmpegFeatures=%FFmpegFeatures%,vorbis,webp,xml2,zlib
rem ,sdl2,opencl
rem NotAvailableInAllPlatform alsa,aom,ass,dav1d,fribidi,ilbc,nvcodec,opengl,ssh,tensorflow,tesseract,vpx

rem FFmpegInteropX libdav1d,openssl 
rem OBS Studio nvenc,amf,libx264,libvpx,libsrt 
rem K-Lite w32threads,libdav1d,libopencore-amrnb,libopencore-amrwb,avisynth,gnutls,gmp

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