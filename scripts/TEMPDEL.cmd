@echo off
rem delete kl source file from _Temp folder
rem delete *.ftx and *.utx files from _Temp folder
rem keep *.kl files from dictionaries
rem keep *.kl files which are needed for includes

SET sourcefile=%1
SET folderpath=%2

rem save current folder path
set "lastpath=%cd%"

rem chang to folder containing file
cd %folderpath%

IF EXIST %sourcefile% (
    DEL %sourcefile%
)

IF EXIST *.ftx (
    DEL *.ftx
)

IF EXIST *.utx (
    DEL *.utx
)

rem set folder to last folder
cd %lastpath%

EXIT /B
rem end of function