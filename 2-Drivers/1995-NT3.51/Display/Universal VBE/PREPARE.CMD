@ECHO OFF
REM VBEMP NT 3.51 preparation helper.
REM Run from a directory containing OEMSETUP.INF, VBEMP.SYS, DISK1
REM and FRAMEBUF.DLL.

IF "%SystemRoot%"=="" GOTO NOTNT
IF NOT EXIST OEMSETUP.INF GOTO NOSOURCE
IF NOT EXIST VBEMP.SYS GOTO NOSOURCE
IF NOT EXIST DISK1 GOTO NOSOURCE
IF NOT EXIST FRAMEBUF.DLL GOTO NOSOURCE

IF EXIST C:\VBEMP\OEMSETUP.INF GOTO EXISTS
IF EXIST C:\VBEMP\VBEMP.SYS GOTO EXISTS
IF EXIST C:\VBEMP\DISK1 GOTO EXISTS
IF EXIST C:\VBEMP\NUL GOTO DIRREADY
MD C:\VBEMP
IF ERRORLEVEL 1 GOTO FAILED

:DIRREADY
COPY OEMSETUP.INF C:\VBEMP\OEMSETUP.INF > NUL
IF ERRORLEVEL 1 GOTO FAILED
COPY VBEMP.SYS C:\VBEMP\VBEMP.SYS > NUL
IF ERRORLEVEL 1 GOTO FAILED
COPY DISK1 C:\VBEMP\DISK1 > NUL
IF ERRORLEVEL 1 GOTO FAILED

IF EXIST %SystemRoot%\SYSTEM32\FRAMEBUF.DLL GOTO DLLPRESENT
COPY FRAMEBUF.DLL %SystemRoot%\SYSTEM32\FRAMEBUF.DLL > NUL
IF ERRORLEVEL 1 GOTO FAILED
ECHO FRAMEBUF.DLL copied to %SystemRoot%\SYSTEM32.
GOTO READY

:DLLPRESENT
ECHO FRAMEBUF.DLL already exists; it has not been overwritten.

:READY
ECHO.
ECHO VBEMP setup files prepared in C:\VBEMP.
ECHO Open Control Panel - Display - Change Display Type... - Change... - Other.
ECHO Enter C:\VBEMP as the OEM source path.
ECHO Select the desired AnaPa Corp VBE Miniport mode.
ECHO When asked for the OEM source, enter C:\VBEMP.
ECHO Restart Windows NT normally after installing the display driver.
GOTO END

:EXISTS
ECHO ERROR: C:\VBEMP already contains installer files.
ECHO Rename or remove that staging folder and run PREPARE.CMD again.
GOTO END

:NOSOURCE
ECHO ERROR: OEMSETUP.INF, VBEMP.SYS, DISK1 and FRAMEBUF.DLL
ECHO must be present in the CURRENT directory.
ECHO Change into the VBEMP folder, then run PREPARE.CMD.
GOTO END

:NOTNT
ECHO ERROR: Run this script from inside Windows NT 3.51.
GOTO END

:FAILED
ECHO ERROR: Copy failed. Do NOT install VBEMP until fixed.

:END
PAUSE
