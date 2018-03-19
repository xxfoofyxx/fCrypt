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
call dl https://raw.githubusercontent.com/xxfoofyxx/fCrypt/master/fCrypt.bat fCrypt.bat
mkdir "C:\Program Files\fCrypt"
move fCrypt.bat "C:\Program Files\fCrypt.bat"
echo Downloading encryption utility...
call dl https://raw.githubusercontent.com/xxfoofyxx/fCrypt/master/aes.exe aes.exe
move aes.exe "C:\Program Files\fCrypt\aes.exe"
cd "C:\Program Files\fCrypt"
echo true>verify
echo Setup is now complete. Would you like to open fCrypt now?
choice
if %ERRORLEVEL%==1 call fCrypt -install
cls
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
rmdir "C:\Program Files\fCrypt"
echo Uninstall completed.
exit /b