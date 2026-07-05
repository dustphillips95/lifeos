@echo off
title LifeOS
cd /d "%~dp0"

REM Check if server already running on port 8000
netstat -ano | findstr ":8000" | findstr "LISTENING" >nul 2>&1
if %errorlevel% == 0 (
    echo Server already running, opening browser...
    start http://localhost:8000/life-dashboard.html
    exit
)

REM Find a working python command
set PYCMD=
python --version >nul 2>&1 && set PYCMD=python
if "%PYCMD%"=="" (
    python3 --version >nul 2>&1 && set PYCMD=python3
)
if "%PYCMD%"=="" (
    py --version >nul 2>&1 && set PYCMD=py
)

if "%PYCMD%"=="" (
    echo ERROR: Python not found.
    echo Install it from https://www.python.org/downloads/
    echo and check "Add to PATH" during install.
    pause
    exit
)

REM Start server minimized in background, then open browser
start /min "LifeOS Server" cmd /c "%PYCMD% -m http.server 8000"

REM Give the server a moment to start
timeout /t 1 /nobreak >nul

REM Open the dashboard
start http://localhost:8000/life-dashboard.html
