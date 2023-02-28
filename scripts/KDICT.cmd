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
    rem form file
    FOR %%I in ("%folderpath%"\*.ftx) DO (
        call :compile %version% "%%I"
    )

    rem dictionary file
    FOR %%I in ("%folderpath%"\*.utx) DO (
        call :compile %version% "%%I"
    )
    
    rem error files
    FOR %%I in ("%folderpath%"\*.etx) DO (
        call :compile %version% "%%I"
    )
) ELSE (   
    call :compile %version% %filename%
)

rem show contet of ktrans.log in TERMINAL
type kdict.log

IF NOT exist compiled mkdir compiled
IF exist "compiled\kdict.log" DEL /F "compiled\kdict.log"

move *.log compiled > nul 
IF EXIST *.tx (
    move *.tx compiled > nul
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
SET kdictversion=%1
SET kdictfilename=%2
IF "%kdictversion%" == "" (
    KCDICT "%kdictfilename%" >> kdict.log 2>nul
) ELSE (   
    KCDICT /ver %kdictversion% "%kdictfilename%" >> kdict.log 2>nul
)

EXIT /B
rem end of function