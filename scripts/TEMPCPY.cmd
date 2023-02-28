@echo off
rem copy kl source file to _Temp folder

SET sourcefile=%1
SET targetfile=%2
SET copyCompiled=%3

rem get folder from target file
SET folder=%~dp2

rem set help variables
SET fileending=%~x1
SET compiledfolder=compiled\
SET targetpath=%~dp2%compiledfolder%
SET sourcefilename=%~dp1%compiledfolder%%~n1
SET targetfilename=%~dp2%compiledfolder%%~n1
SET pc=.pc
SET tx=.tx
SET vr=.vr

rem variables to get vr files of ftx
SET filename=%~n1
SET sourcevarpath=%~dp1%
SET targetvarpath=%~dp2%
SET filendinggr=gr
SET sourcevarfilenameen=%sourcevarpath%%filename:~2,-2%%vr%
SET targetvarfilenameen=%targetvarpath%%compiledfolder%%filename:~2,-2%%vr%
SET sourcevarfilenamegr=%sourcevarpath%%filename:~2,-2%%filendinggr%%vr%
SET targetvarfilenamegr=%targetvarpath%%compiledfolder%%filename:~2,-2%%filendinggr%%vr%


rem if _TEMP folder does not exist create it
IF NOT exist %folder% (
    mkdir %folder%
)

COPY %sourcefile% %targetfile%

rem copy from _TEMP\compiled folder to module\compiled folder
IF %copyCompiled%=="True" (

    rem create compiled folder
    IF NOT exist %targetpath% (
        mkdir %targetpath%
    )

    IF %fileending% == .kl (
        rem copy to compiled folder
        COPY %sourcefilename%%pc% %targetfilename%%pc%
    )
    IF %fileending% == .ftx (
        rem copy to compiled folder
        COPY %sourcefilename%%tx% %targetfilename%%tx%

        rem check language of dict
        IF %sourcefilename:~-2% == gr (
            COPY %sourcevarfilenamegr% %targetvarfilenamegr%
        ) ELSE (
            COPY %sourcevarfilenameen% %targetvarfilenameen%
        )
    )
    IF %fileending% == .utx (
        rem copy to compiled folder
        COPY %sourcefilename%%tx% %targetfilename%%tx%
    )
)

EXIT /B
rem end of function