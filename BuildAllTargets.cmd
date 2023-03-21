@setlocal
@echo off

rem Change to the current folder.
cd "%~dp0"

rem Remove the output folder for a fresh compile.
rd /s /q Output

rem Initialize Visual Studio environment
call "%~dp0Mile.Project.Windows\InitializeVisualStudioEnvironment.cmd"

rem Build all targets
MSBuild -binaryLogger:Output\BuildAllTargets.binlog -m BuildAllTargets.proj

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