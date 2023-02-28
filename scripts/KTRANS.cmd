@echo off
rem This batch file provides 
rem the possibility to compile
rem FANUC Karel files with ktrans
rem
rem input parameter 
rem 1 folder path
rem 2 ktrans version
rem 3 filename
rem
SET folderpath=%1
SET version=%2 
SET filename=%3

rem save current folder path
set "lastpath=%cd%"

rem chang to folder containing file
cd %folderpath%

rem check if there is a specific file set to compile
rem if not compile the whole directory
IF "%filename%" == "" (
    FOR %%I in ("%folderpath%"\*.kl) DO (
        call :compile %version% "%%I"
    )
) ELSE (   
    call :compile %version% %filename%
)

rem show contet of ktrans.log in TERMINAL
type ktrans.log

IF NOT exist compiled mkdir compiled
IF exist "compiled\ktrans.log" DEL /F "compiled\ktrans.log"

move *.log compiled > nul 
IF EXIST *.pc (
    move *.pc compiled > nul
) ELSE (
        EXIT
)

echo.
echo finished compiling

rem set folder to last folder
cd %lastpath%

EXIT /B

rem end of main
rem

rem function to compile kl file
rem
rem input parameter 
rem 1 ktrans version
rem 2 filename
rem
rem FUNCTION COMPILE
:compile
SET ktransversion=%1
SET ktransfilename=%2

rem check if file is really a program
Setlocal EnableDelayedExpansion 
FINDSTR /I /B "PROGRAM " "%ktransfilename%" > nul
if !errorlevel! == 0 (
    echo FILE: %ktransfilename% >> ktrans.log
) ELSE (
    echo FILE: %ktransfilename% is no PROGRAM >> ktrans.log
    EXIT
)

IF "%ktransversion%" == "" (
    ktrans "%ktransfilename%" >> ktrans.log 2>nul
) ELSE (   
    ktrans /ver %ktransversion% "%ktransfilename%" >> ktrans.log 2>nul
)

EXIT /B
rem end of function