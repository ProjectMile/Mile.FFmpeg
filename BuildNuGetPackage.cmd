@rem 
@rem PROJECT:   Mouri Internal Library Essentials
@rem FILE:      BuildNuGetPackage.cmd
@rem PURPOSE:   Build NuGet Package
@rem 
@rem LICENSE:   The MIT License
@rem 
@rem DEVELOPER: Mouri_Naruto (Mouri_Naruto AT Outlook.com)
@rem 

@setlocal
@echo off

rem Change to the current folder.
cd "%~dp0Output"

rem Build NuGet Package
D:\Tools\nuget.exe pack ..\Mile.FFmpeg\Mile.FFmpeg.nuspec

@endlocal