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
7z a -r Output\Mile.FFmpeg.Symbols.zip .\Output\Binaries\Release\*.pdb
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

rem Extract files from NuGet package to folder
7z x Output\Mile.FFmpeg.nupkg "-o.\Output\Mile.FFmpeg"
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

rem Copy Documents
rename .\Output\Mile.FFmpeg\build\native\*.md *.txt
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%

rem Build SDK Package
7z a -r Output\Mile.FFmpeg.zip .\Output\Mile.FFmpeg\build\native\*.*

@endlocal