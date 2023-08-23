@echo off
cls
echo HackBGRT Easy Install script by ryanrudolf
echo https://github.com/ryanrudolfoba/HackBGRT-Easy-Install
echo.
ping -n 3 localhost > nul

rem - mount the esp partition
mountvol u: /s > nul
if %ERRORLEVEL%==1 (echo Error mounting EFI system partition!
echo No changes made, exiting immediately!
goto end) else goto esp_good

:esp_good
rem - check if Clover exists in the esp
dir u:\efi\Clover > nul 2>&1
if %ERRORLEVEL%==0 (echo Clover has been detected! Exiting immediately!
goto end) else echo Clover not detected! Proceeding to the next step!

rem - backup the Windows boot manager
dir u:\efi\Microsoft\Boot\bootmgfw-orig.efi > nul 2>&1
if %ERRORLEVEL%==1 (copy u:\efi\Microsoft\Boot\bootmgfw.efi u:\efi\Microsoft\Boot\bootmgfw-orig.efi > nul
echo Windows boot manager has been backed up!) else echo Windows boot manager has already been backed up!

rem - copy HackBGRT files to the esp
xcopy /y /s /e /i HackBGRT u:\efi\HackBGRT > nul
copy /y u:\efi\Microsoft\Boot\bootmgfw-orig.efi u:\efi\HackBGRT > nul
copy /y u:\efi\HackBGRT\HackBGRT.efi u:\efi\Microsoft\Boot\bootmgfw.efi > nul

echo HackBGRT files has been copied!
echo HackBGRT install completed!

:end
mountvol u: /d > nul
pause
exit