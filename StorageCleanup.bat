@echo off

:: https://sites.google.com/site/eneerge/scripts/batchgotadmin
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  

echo ===============================================
echo Please ignore errors in most case, it is normal.
echo ===============================================
ping 127.0.0.1 -n 6 > nul

:: Spotify
:: taskkill /IM Spotify.exe /F
:: rmdir %localappdata%\Spotify\Data\ /S /Q
:: mkdir %localappdata%\Spotify\Data\

:: Unity
taskkill /IM Unity.Licensing.Client.exe /F
taskkill /IM Unity.exe /F
taskkill /IM "Unity Hub.exe" /F
rmdir %localappdata%\Unity\cache\ /S /Q
rmdir %appdata%\..\LocalLow\Unity\Caches /S /Q
mkdir %localappdata%\Unity\cache\
mkdir %appdata%\..\LocalLow\Unity\Caches

:: DXCache
:: del /S /F /Q %localappdata%\NVIDIA\DXCache\*

:: LINE Call
taskkill /IM LINE.exe /F
taskkill /IM LineCall.exe /F
taskkill /IM LineMediaPlayer.exe /F
rmdir %localappdata%\LineCall\Cache\ /S /Q
rmdir %localappdata%\LINE\Cache\ /S /Q
mkdir %localappdata%\LineCall\Cache\
mkdir %localappdata%\LINE\Cache\
del /S /F /Q %localappdata%\LineCall\log

:: Rufus
del /F /Q %localappdata%\Rufus\rufus.log

:: Yarn
rmdir %localappdata%\Yarn\Cache\ /S /Q
mkdir %localappdata%\Yarn\Cache\

:: VRChat
taskkill /IM VRChat.exe /F
rmdir %appdata%\..\LocalLow\VRChat\VRChat\Cache-WindowsPlayer /S /Q
mkdir %appdata%\..\LocalLow\VRChat\VRChat\Cache-WindowsPlayer
del /F /Q %appdata%\..\LocalLow\VRChat\VRChat\output_log_*.txt

:: Minecraft
taskkill /IM MinecraftLauncher.exe /F
rmdir %appdata%\.minecraft\logs\ /S /Q
rmdir %appdata%\.minecraft\crash-reports\ /S /Q
mkdir %appdata%\.minecraft\logs\
mkdir %appdata%\.minecraft\crash-reports\

:: Lunar Client
taskkill /IM "Lunar Client.exe" /F
rmdir %userprofile%\.lunarclient\logs\ /S /Q
rmdir %userprofile%\.lunarclient\game-cache\ /S /Q
rmdir %userprofile%\.lunarclient\launcher-cache\ /S /Q
mkdir %userprofile%\.lunarclient\logs\
mkdir %userprofile%\.lunarclient\game-cache\
mkdir %userprofile%\.lunarclient\launcher-cache\

:: Razer Synapse3
net stop "Razer Synapse Service" /Y
taskkill /F /IM "Razer Synapse*" 2
taskkill /IM "Razer Central.exe" /F
rmdir C:\ProgramData\Razer\Synapse3\Log\ /S /Q
rmdir C:\ProgramData\Razer\Synapse3\CrashDumps\ /S /Q
rmdir C:\ProgramData\Razer\GameManager\Logs\ /S /Q
mkdir C:\ProgramData\Razer\Synapse3\Log\
mkdir C:\ProgramData\Razer\Synapse3\CrashDumps\
mkdir C:\ProgramData\Razer\GameManager\Logs\
net start "Razer Synapse Service" 1> NUL 2>&1
START "" "C:\Program Files (x86)\Razer\Synapse3\WPFUI\Framework\Razer Synapse 3 Host\Razer Synapse 3.exe" > NUL

:: CrashDumps
del /F /Q %localappdata%\CrashDumps\*

:: WinSys
dism /online /Cleanup-Image /StartComponentCleanup /ResetBase
dism /online /Cleanup-Image /SPSuperseded

echo Done...
pause