@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Virtio certificate install

set "CA=%~dp0Virtio_Win_Red_Hat_CA.cer"
set "CERTUTIL=%SystemRoot%\System32\certutil.exe"

if not exist "%CA%" (
    echo Failure: Certificate file not found:
    echo "%CA%"
    goto FAILED
)

if not exist "%CERTUTIL%" (
    if defined PROCESSOR_ARCHITEW6432 (
        set "BUNDLED_ARCH=%PROCESSOR_ARCHITEW6432%"
    ) else (
        set "BUNDLED_ARCH=%PROCESSOR_ARCHITECTURE%"
    )
    if /i "!BUNDLED_ARCH!"=="AMD64" set "BUNDLED_ARCH=x64"
    if /i "!BUNDLED_ARCH!"=="x86" set "BUNDLED_ARCH=x86"
    if not "!BUNDLED_ARCH!"=="x86" if not "!BUNDLED_ARCH!"=="x64" (
        echo Failure: No bundled certutil.exe is available for !BUNDLED_ARCH!.
        goto FAILED
    )
    set "CERTUTIL=%~dp0Tools\!BUNDLED_ARCH!\certutil.exe"
    if not exist "!CERTUTIL!" (
        echo Failure: certutil.exe was not found in Windows or the bundled tools.
        goto FAILED
    )
)

echo Installing Virtio_Win_Red_Hat_CA.cer into the Local Computer Root store...
"%CERTUTIL%" -f -addstore Root "%CA%"
if errorlevel 1 goto ROOT_FAILED

echo Installing Virtio_Win_Red_Hat_CA.cer into the Local Computer Trusted Publisher store...
"%CERTUTIL%" -f -addstore TrustedPublisher "%CA%"
if errorlevel 1 goto PUBLISHER_FAILED

echo.
echo Certificate installation completed successfully.
goto DONE

:ROOT_FAILED
echo.
echo Failure: Could not add the certificate to the Root store.
echo Run this script from an Administrator account.
goto FAILED

:PUBLISHER_FAILED
echo.
echo Failure: Certificate was added to Root, but could not be added to Trusted Publisher.
echo Run this script from an Administrator account.
goto FAILED

:FAILED
echo.
pause
exit /b 1

:DONE
echo.
pause
exit /b 0
