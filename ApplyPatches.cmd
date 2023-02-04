@setlocal

@echo off

set PatchesFolder="%~dp0Patches"
set VcpkgFolder="%~dp0Mile.FFmpeg.Vcpkg"

pushd %VcpkgFolder%
git am %PatchesFolder%\add-triplets-for-building-release-version-of-static-libraries-only.patch
if %ERRORLEVEL% NEQ 0 exit /B %ERRORLEVEL%
popd

@endlocal