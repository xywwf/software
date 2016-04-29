@echo off
CALL :IF_EXIST 7za.EXE || exit
CALL :IF_EXIST CURL.EXE && set curl=1
CALL :IF_EXIST wget.EXE && set wget=1
if defined curl (
rem   set tool=curl -C - -m 5 --retry-delay 2 -o master -k -L 
  set tool=curl -C - -o master -k -L 
) else (
  if not defined wget (
    exit
  ) else (
    set tool=wget -c --no-check-certificate 
  )
)
echo using %tool% to download>scripts.log
set vimpath=%cd%\vimfiles
for /f "eol=#" %%x in (vim.scripts.conf) do call :download %%x

pause
exit

:download
for /f "tokens=1* delims=/" %%a in ("%1") do set creator=%%a&&set name=%%b
if not defined name (
	set creator=vim-scripts
	set name=%creator%
)
set url=https://github.com/%creator%/%name%/archive/master.zip
rem wget -c -e "http_proxy=http://127.0.0.1:8580/" %url% --no-check-certificate
%tool% %url%
if not exist master goto :eof
7za x master -xr!README*
xcopy /E /R /Y %name%-master\* %vimpath%\
echo setup %name% OK!>>scripts.log
del master
rd /s /q %name%-master

:IF_EXIST
SETLOCAL&PATH %PATH%;%~dp0;%cd%
if "%~$PATH:1"=="" exit /b 1
echo %~$PATH:1
exit /b 0