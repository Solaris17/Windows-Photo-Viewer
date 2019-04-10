@echo off
SET build=1.1
title Windows Photo Viewer v%BUILD%

:checkPrivileges
:: Check for Admin by accessing protected stuff. This calls net(#).exe and can stall if we don't kill it later.
NET FILE 1>nul 2>&1 2>nul 2>&1
if '%errorlevel%' == '0' ( goto main) else ( goto getPrivileges ) 

:getPrivileges
:: Write vbs in temp to call batch as admin.
if '%1'=='ELEV' (shift & goto main)                               
for /f "delims=: tokens=*" %%A in ('findstr /b ::- "%~f0"') do @Echo(%%A
setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
Echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs" 
Echo UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs" 
"%temp%\OEgetPrivileges.vbs" 
exit /B

:main
cls
Echo.
Echo This will change the base image type defaults to open with Photo Viewer
Echo.
Echo Photo Viewer is still availible for Win 8 and above
Echo.
Echo It's just not selectable and I think the new version sucks.
Echo.
pause
cls
Echo.
Echo Writing registry modifications
Echo.
Echo Setting default image type support
Echo.
:: You can copy these lines and insert other extensions. Just make sure there is a root key for them first.
:: Remember that photo viewer might not be able to open all types of files. 
reg.exe add "HKCU\Software\Classes\.jpg" /T "REG_SZ" /D "PhotoViewer.FileAssoc.Tiff" /F >nul 2>&1
reg.exe add "HKCU\Software\Classes\.jpeg" /T "REG_SZ" /D "PhotoViewer.FileAssoc.Tiff" /F >nul 2>&1
reg.exe add "HKCU\Software\Classes\.gif" /T "REG_SZ" /D "PhotoViewer.FileAssoc.Tiff" /F >nul 2>&1
reg.exe add "HKCU\Software\Classes\.png" /T "REG_SZ" /D "PhotoViewer.FileAssoc.Tiff" /F >nul 2>&1
reg.exe add "HKCU\Software\Classes\.bmp" /T "REG_SZ" /D "PhotoViewer.FileAssoc.Tiff" /F >nul 2>&1
reg.exe add "HKCU\Software\Classes\.tiff" /T "REG_SZ" /D "PhotoViewer.FileAssoc.Tiff" /F >nul 2>&1
reg.exe add "HKCU\Software\Classes\.ico" /T "REG_SZ" /D "PhotoViewer.FileAssoc.Tiff" /F >nul 2>&1
Echo Done!
Echo.
pause
Exit