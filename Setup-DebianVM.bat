@echo off
REM Debian VM Automated Setup - Batch Wrapper
REM This batch file runs the automated PowerShell script with Administrator privileges

echo ========================================
echo Debian 13 VM Automated Setup
echo ========================================
echo.
echo This script will automatically:
echo - Check all prerequisites
echo - Download Debian 13 ISO
echo - Create and configure VM
echo - Install Debian (unattended)
echo - Configure static IP and SSH
echo - Install Docker Engine
echo - Launch Windows Terminal with SSH
echo.
echo Prerequisites:
echo - VirtualBox must be installed
echo - .env file must be configured
echo.
echo This process takes 20-30 minutes.
echo.
pause

REM Run PowerShell script with Administrator privileges
echo Requesting Administrator privileges...
echo.
powershell.exe -Command "Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File \"%~dp0Setup-DebianVM.ps1\"' -Verb RunAs"

echo.
echo ========================================
echo Script launched with elevated privileges
echo Check the new PowerShell window for progress
echo ========================================
echo.
pause
