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
set FFmpegCoreFeatures=avcodec,avdevice,avfilter,avformat,avresample,swresample,swscale
set FFmpegFeatures=%FFmpegCoreFeatures%,bzip2,fontconfig,freetype,iconv,lzma,mp3lame,openjpeg,opus,snappy,soxr,speex,theora,vorbis,webp,xml2,zlib,sdl2,modplug,opencl,openh264
rem NotAvailableInAllPlatform alsa,aom,ass,dav1d,fribidi,ilbc,nvcodec,opengl,ssh,tensorflow,tesseract,vpx

rem FFmpegInteropX zlib,bzlib,lzma,libxml2,iconv,libdav1d,openssl 
rem OBS Studio nvenc,amf,libx264,libopus,libvorbis,libvpx,libsrt 
rem K-Lite w32threads,libdav1d,libspeex,libopencore-amrnb,libopencore-amrwb,avisynth,gnutls,gmp,libxml2,zlib

rem Build FFmpeg via vcpkg
vcpkg install ffmpeg[%FFmpegFeatures%]:x86-windows-static ffmpeg[%FFmpegFeatures%]:x64-windows-static ffmpeg[%FFmpegFeatures%]:arm-windows-static ffmpeg[%FFmpegFeatures%]:arm64-windows-static 

@endlocal