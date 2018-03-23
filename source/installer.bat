@echo off
cls
echo WARNING: This installer needs to be run as admin in order to work!
pause
cls
if "%1"=="uninstall" goto uninstall
if not exist "C:\Program Files\fCrypt" goto setup
echo fCrypt is already installed on this system.
pause
exit /b


:setup
ping www.github.com >NUL
if %ERRORLEVEL%==1 echo GitHub cannot be reached right now. Please try again later. & exit /b
echo --------------------------------------------------
echo Setup is now installing fCrypt on your computer...
echo --------------------------------------------------
echo.
echo Downloading latest version...
call dl https://raw.githubusercontent.com/xxfoofyxx/fCrypt/master/source/fCrypt.bat fCrypt.bat 2 >nul
mkdir "C:\Program Files\fCrypt"
move fCrypt.bat "C:\Program Files\fCrypt\fCrypt.bat" >nul
call dl https://raw.githubusercontent.com/xxfoofyxx/fCrypt/master/source/aes.exe aes.exe 2 >nul
move aes.exe "C:\Program Files\fCrypt\aes.exe" >nul
cd "C:\Program Files\fCrypt"
::20 zeros because the aes utility requires at least 16 bytes (20 0s = 20 bytes)
echo 00000000000000000000>verify
cls
echo Setup is now complete.
echo Press any key to exit Setup...
pause >nul
exit /b

:uninstall
echo Are you sure? Once you uninstall fCrypt, all your data will be lost forever!
choice
if %ERRORLEVEL%==2 echo Uninstall canceled. & exit /b
echo Are you COMPLETELY sure you want to do this? This is your last chance!
choice
if %ERRORLEVEL%==2 echo Uninstall canceled. & exit /b
echo Ok, uninstalling now.
del "C:\Program Files\fCrypt\*" /q /y
rmdir "C:\Program Files\fCrypt" /s /q
echo Uninstall completed.
exit /b