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
cd "%~dp0vcpkg"

rem Bootstrap vcpkg
rem call bootstrap-vcpkg.bat

rem Set features list
set FFmpegFeatures=avcodec,avdevice,avfilter,avformat,avresample,swresample,swscale
set FFmpegFeatures=%FFmpegFeatures%,bzip2,iconv,lzma,opus,speex,vorbis,xml2,zlib
set FFmpegFeatures=%FFmpegFeatures%,modplug,mp3lame,openh264,openjpeg,snappy,soxr,theora,webp
rem ,fontconfig,freetype,sdl2,opencl
rem NotAvailableInAllPlatform alsa,aom,ass,dav1d,fribidi,ilbc,nvcodec,opengl,ssh,tensorflow,tesseract,vpx

rem FFmpegInteropX libdav1d,openssl 
rem OBS Studio nvenc,amf,libx264,libvpx,libsrt 
rem K-Lite w32threads,libdav1d,libopencore-amrnb,libopencore-amrwb,avisynth,gnutls,gmp

rem Build FFmpeg via vcpkg
vcpkg install ffmpeg[%FFmpegFeatures%]:x86-windows-static ffmpeg[%FFmpegFeatures%]:x64-windows-static ffmpeg[%FFmpegFeatures%]:arm-windows-static ffmpeg[%FFmpegFeatures%]:arm64-windows-static 

@endlocal