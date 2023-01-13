@setlocal

@echo off

set PatchesFolder="%~dp0Patches"
set VcpkgFolder="%~dp0Mile.FFmpeg.Vcpkg"

pushd %VcpkgFolder%
@REM git am %PatchesFolder%\0001-Only-build-release-versions-of-static-libraries.patch
@REM if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
git am %PatchesFolder%\adjust-ffmpeg-port-dependencies-policy.patch
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

@endlocal