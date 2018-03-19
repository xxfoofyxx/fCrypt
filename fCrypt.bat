@echo off
if not exist verify set creason=NX-VERIFY & goto crash
echo Enter your password to access your files:
set /p p=^>
if "%1"=="-install" not exist Files set ensf=verify & call :ensf & mkdir Files
aes -d "%p%" verify verify.tmp
if %ERRORLEVEL%==1 echo Password incorrect. & timeout /t 3 >NUL & goto start
del verify.tmp
:menu
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
goto menu

:ensf
aes -e "%p%" "%ensf%" ENSF.TMP
del "%ensf%"
copy ENSF.TMP "%ensf%"
del ENSF.TMP
goto :EOF

:dcsf
aes -d "%p%" "%dcsf%" dcsf.TMP
del "%dcsf%"
copy dcsf.TMP "%dcsf%"
del dcsf.TMP
goto :EOF

:open
cls
echo Open which file?
set /p dcsf=^>
call :dcsf
start %dcsf%
echo Press any key when you are done...
pause >nul
set ensf=%dcsf%
call :ensf
goto menu

:delete
cls
echo Delete which file?
set /p delete=^>
cls
echo Are you sure you want to delete %delete%?
choice
if %ERRORLEVEL%==2 echo Deletion cancelled. & timeout /t 3 >nul & goto menu
cls
del /q /y "%delete%"
echo Deleted %delete%.
timeout /t 3 >nul
goto menu

:add
cls
echo Add which file?
echo NOTE: Please enter the full path of the file, not just the name.
set /p ensf=^>
if not exist %ensf% goto add
call :ensf
move "%ensf%" "C:\Program Files\fCrypt\Files\"
cls
echo File added.
timeout /t 3 >nul
goto menu

::extra line to prevent code overrun
set creason=END-OF-CODE
:crash
if not defined creason set creason=NO-REASON-SPECIFIED
echo.
echo Sorry, but fCrypt has crashed.
echo Reason specified:
echo %creason%
echo.
echo Try restarting fCrypt. If this doesn't work then re-install it.
echo If, after re-installing it it does not work contact xxfoofyxx on GitHub.
echo.
set cdumpfile=crash_%random%.txt
echo --Crashdump generated on %date% at %time%-- >>%cdumpfile%
echo. >>%cdumpfile%
echo Reason specified: >>%cdumpfile%
echo. >>%cdumpfile%
echo %creason% >>%cdumpfile%
echo. >>%cdumpfile%
echo VARS: >>%cdumpfile%
echo ENSF=%ensf% >>%cdumpfile%
echo DCSF=%dcsf% >>%cdumpfile%
echo ERRORLEVEL=%ERRORLEVEL% >>%cdumpfile%
echo. >>%cdumpfile%
echo DIR OUTPUT: >>%cdumpfile%
dir >>%cdumpfile%
echo. >>%cdumpfile%
echo CURRENT DIRECTORY: >>%cdumpfile%
echo %CD% >>%cdumpfile%
echo. >>%cdumpfile%
echo CURRENT SCRIPT NAME: >>%cdumpfile%
echo %0 >>%cdumpfile%
echo. >>%cdumpfile%
echo OUTPUT OF TASKLIST: >>%cdumpfile%
tasklist >>%cdumpfile%
echo. >>%cdumpfile%
echo. >>%cdumpfile%
echo End of crashdump. >>%cdumpfile%
echo Details of the crash were saved to
echo %cdumpfile%
pause
exit /b