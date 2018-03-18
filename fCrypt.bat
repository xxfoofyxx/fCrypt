@echo off
echo Enter your password to access your files:
set /p p=^>
if "%1"=="-install" not exist Files set ensf=verify & call :ensf & mkdir Files
aes -d "%p%" verify verify.tmp
if %ERRORLEVEL%==1 echo Password incorrect. & timeout /t 3 >NUL & goto start
del verify.tmp
cls
echo Welcome back. What would you like to do?
echo 1) Open a file
echo 2) Delete a file
echo 3) Add a file
echo 4) Exit
choice /c:1234 /n
if %ERRORLEVEL%==1 goto open
if %ERRORLEVEL%==2 goto delete
if %ERRORLEVEL%==3 goto add
if %ERRORLEVEL%==4 exit /b

:ensf
aes -e "%p%" %ensf% ENSF.TMP
del %ensf%
copy ENSF.TMP %ensf%
del ENSF.TMP
goto :EOF

:dcsf
aes -d "%p%" %dcsf% dcsf.TMP
del %dcsf%
copy dcsf.TMP %dcsf%
del dcsf.TMP
goto :EOF
