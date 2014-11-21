@echo off
mode con:cols=52 lines=17
echo LOADING FILES..
"7z.exe" x "tools.zip">nul
adb kill-server>nul
set installation=Not installed
if exist %systemdrive%\adb\adb.exe (
if exist %systemdrive%\adb\AdbWinApi.dll (
if exist %systemdrive%\adb\AdbWinUsbApi.dll (
if exist %systemdrive%\adb\fastboot.exe (
set installation=Installed
)
)
)
)
:adbmenu
cls
echo ====================================================
echo.
echo   Quick ADB, fastboot and driver installer/updater
echo.
echo                   Adb/fastboot menu
echo           ADB/Fasboot status - %installation%
echo.
echo ====================================================
echo.
set /p choice=Install/update adb and fastboot? Y/N :
if %choice% == y goto installadb
if %choice% == Y goto installadb
if %choice% == yes goto installadb
if %choice% == Yes goto installadb
if %choice% == n goto drivermenu
if %choice% == N goto drivermenu
if %choice% == no goto drivermenu
if %choice% == No goto drivermenu

:installadb
cls
if exist %systemdrive%\adb rmdir /s /q %systemdrive%\adb>nul
"7z.exe" x "adb.zip" -o"%systemdrive%">nul
echo %path% > tmp.txt
find "%systemdrive%\adb" tmp.txt>nul
if %errorlevel% == 0 goto installedadb
"setx.exe" path "%path%;%systemdrive%\adb">nul
pause

:installedadb
cls
echo ====================================================
echo.
echo   Quick ADB, fastboot and driver installer/updater
echo.
echo      SUCCESSFULL INSTALLED/UPDATED ADB/FASTBOOT
echo.
echo ====================================================
echo.
ping -n 2 -w 200 127.0.0.1>nul

:drivermenu
cls
echo ====================================================
echo.
echo   Quick ADB, fastboot and driver installer/updater
echo.
echo                     Driver menu
echo.
echo ====================================================
echo.
set /p choice=Install/update device drivers? Y/N :
if %choice% == y goto installdriver
if %choice% == Y goto installdriver
if %choice% == yes goto installdriver
if %choice% == Yes goto installdriver
if %choice% == n goto exit
if %choice% == N goto exit
if %choice% == no goto exit
if %choice% == No goto exit

:installdriver
cls
if exist "%systemdrive%\Program Files (x86)" (
start /wait x64.exe
)
if not exist "%systemdrive%\Program Files (x86)" (
start /wait x86.exe
)
goto installeddriver

:installeddriver
cls
echo ====================================================
echo.
echo   Quick ADB, fastboot and driver installer/updater
echo.
echo        SUCCESSFULL INSTALLED/UPDATED DRIVERS
echo.
echo ====================================================
echo.
ping -n 2 -w 200 127.0.0.1>nul

:exit
cls
echo ====================================================
echo.
echo             THANKS FOR USING THE TOOL
echo                 Ricky Divjakovski
echo.
echo ====================================================
echo.
pause
exit
