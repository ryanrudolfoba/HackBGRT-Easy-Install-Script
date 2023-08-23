@echo off
cls
echo HackBGRT Uninstall script by ryanrudolf
echo https://github.com/ryanrudolfoba/HackBGRT-Easy-Install
echo.
ping -n 3 localhost > nul

rem - mount the esp partition
mountvol u: /s > nul
if ERRORLEVEL 1 (echo Error mounting EFI system partition!
echo No changes made, exiting immediately!
goto end) else goto esp_good

:esp_good
rem - restore the Windows boot manager
dir u:\efi\Microsoft\Boot\bootmgfw-orig.efi > nul 2>&1
if %ERRORLEVEL%==0 (copy /y u:\efi\Microsoft\Boot\bootmgfw-orig.efi u:\efi\Microsoft\Boot\bootmgfw.efi > nul
del /q u:\efi\Microsoft\Boot\bootmgfw-orig.efi > nul
echo Windows boot manager has been restored!) else (echo Windows boot manager backup does not exist! Exiting immediately!
goto end)

rem - remove HackBGRT files from the esp
dir u:\efi\HackBGRT > nul 2>&1
if %ERRORLEVEL%==0 (rmdir /s /q u:\efi\HackBGRT > nul
echo HackBGRT files has been removed!
echo HackBGRT uninstall completed!) else (echo HackBGRT files does not exist!
goto end)

:end
mountvol u: /d > nul
pause
exit