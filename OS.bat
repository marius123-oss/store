@echo off
call updater.bat
title MariusOS
color 0A
:OS

set /p usr=<usr.txt
set /p pas=<pas.txt

if not exist pas.txt (
 del files\*.* /F /Q
 del "apps\Web-Browser.bat"
 del "apps\Timer.bat"
 goto userset
)

if not exist usr.txt (
 del files\*.*
 del "apps\Web-Browser.bat"
 del "apps\Timer.bat"
 goto userset
)

if exist logged.txt (
goto desktop
)
cls
echo Starting Services...
timeout 1 >nul
echo started loginap.msc
timeout 1 >nul
echo started appssrv.msc
timeout 1 >nul
echo started menuserv.msc
timeout 1 >nul
echo started files.msc
timeout 1 >nul 
echo started boot.msc
echo.

echo Done! Please Wait For MariusOS to start up!
timeout 10 >nul
cls
set started=1 >nul
goto mainOS

:mainOS
echo                                                   Welcome to MariusOS!
echo ________________________________________________________________________________________________________________________
echo Welcome, %usr%
echo.
set /p input=Password:
if %input% EQU off goto shut2 
if %input% == %pas% (
echo Unlocked!
pause
echo. > logged.txt
goto desktop
) else (
echo Incorrect passcode!
pause
cls
goto mainOS
)




:userset
cls
echo Welcome To User Setup! This Setup will setup your user! Go!
echo Creating User File...
set /p input=User: 
echo %input% > usr.txt
echo User File Created!
echo Creating Password File...
set /p input=Password: 
echo %input% > pas.txt
echo Password File Created!
echo Rebooting...
cls
echo rebooting...
timeout 6 >nul
cls
goto OS

:desktop
cls
echo 1)Apps
echo.
echo 2)LogOut
echo.
echo 3)ShutDown
set /p input=Choice: 
if %input% == 1 goto app
if %input% == 2 goto logout
if %input% == 3 goto shut






:app
cls
echo Apps:
echo type "exit" to go on desktop
echo You Dont need to also type the extension!
echo.
for %%f in ("apps\*.bat") do echo   - %%~nf
set /p input=Enter app name to launch: 
if %input% == exit goto desktop
if exist apps\%input%.bat (
start apps\%input%.bat
exit
) else (
echo This app dosent exist in your computer!
timeout 1 >nul
cls
goto desktop
)
:LogOut
cls
del logged.txt >nul
cls
goto mainOS

:shut
cls
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Are You sure you want to shutdown? It will terminate this sesion of MariusOS.', 'Warning', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Warning);}" > %TEMP%\out.tmp
set /p OUT=<%TEMP%\out.tmp
if %OUT% == Yes (
echo Unlogging user...
timeout 3 >nul
del logged.txt
echo.
echo Shutting down MariusOS...
timeout 7 >nul
exit
) else (
cls
goto desktop
)

:shut2
cls
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Are You sure you want to shutdown? It will terminate this sesion of MariusOS.', 'Warning', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Warning);}" > %TEMP%\out.tmp
set /p OUT=<%TEMP%\out.tmp
if %OUT% == Yes (
echo Unlogging user...
timeout 3 >nul
echo Shutting down MariusOS...
timeout 7 >nul
exit
) else (
cls
goto mainOS
)


