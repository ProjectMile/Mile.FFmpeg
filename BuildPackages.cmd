@rem 
@rem PROJECT:   Mouri Internal Library Essentials
@rem FILE:      BuildPackages.cmd
@rem PURPOSE:   Build Packages
@rem 
@rem LICENSE:   The MIT License
@rem 
@rem DEVELOPER: Mouri_Naruto (Mouri_Naruto AT Outlook.com)
@rem 

@setlocal
@echo off

rem Change to the current folder.
cd "%~dp0Output"

rem Remove the output folder for a fresh compile.
rd /s /q Mile.FFmpeg
del Mile.FFmpeg.nupkg
del Mile.FFmpeg.Symbols.zip
del Mile.FFmpeg.zip

rem Build NuGet Package
D:\Tools\nuget.exe pack -OutputFileNamesWithoutVersion ..\Mile.FFmpeg\Mile.FFmpeg.nuspec
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

rem Build Symbol Package
7z a -r Mile.FFmpeg.Symbols.zip .\Binaries\Release\*.pdb
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

rem Extract files from NuGet package to folder
7z x Mile.FFmpeg.nupkg "-o.\Mile.FFmpeg"
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

rem Copy Documents
rename .\Mile.FFmpeg\build\native\*.md *.txt
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

rem Build SDK Package
7z a -r Mile.FFmpeg.zip .\Mile.FFmpeg\build\native\*.*

@endlocal