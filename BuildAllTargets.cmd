@setlocal
@echo off

rem Change to the current folder.
cd "%~dp0"

rem Remove the output folder for a fresh compile.
rd /s /q Output

rem Initialize Visual Studio environment
set VisualStudioInstallerFolder="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer"
if %PROCESSOR_ARCHITECTURE%==x86 set VisualStudioInstallerFolder="%ProgramFiles%\Microsoft Visual Studio\Installer"
pushd %VisualStudioInstallerFolder%
for /f "usebackq tokens=*" %%i in (`vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
  set VisualStudioInstallDir=%%i
)
popd
call "%VisualStudioInstallDir%\VC\Auxiliary\Build\vcvarsall.bat" x86

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