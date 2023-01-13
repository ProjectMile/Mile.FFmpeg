@setlocal

@echo off

set PatchesFolder="%~dp0Patches"
set VcpkgFolder="%~dp0Mile.FFmpeg.Vcpkg"

pushd %VcpkgFolder%
git am %PatchesFolder%\0001-Only-build-release-versions-of-static-libraries.patch
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
git am %PatchesFolder%\0002-Adjust-FFmpeg-port-dependencies-policy.patch
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

@endlocal