@rem 
@rem PROJECT:   Mouri Internal Library Essentials
@rem FILE:      BuildFFmpeg.cmd
@rem PURPOSE:   Build FFmpeg via vcpkg
@rem 
@rem LICENSE:   The MIT License
@rem 
@rem MAINTAINER: MouriNaruto (Kenji.Mouri@outlook.com)
@rem 

@setlocal
@echo off

rem Change to the current folder.
cd "%~dp0Mile.FFmpeg.Vcpkg"

rem Bootstrap vcpkg
call bootstrap-vcpkg.bat

set VcpkgOptions= --overlay-triplets=..\Mile.FFmpeg.Vcpkg.ExtraTriplets

rem Build FFmpeg via vcpkg
vcpkg install %VcpkgOptions% ffmpeg[all]:x86-windows-static-release
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
vcpkg install %VcpkgOptions% ffmpeg[all]:x64-windows-static-release
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
vcpkg install %VcpkgOptions% ffmpeg[all]:arm64-windows-static-release
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

@endlocal