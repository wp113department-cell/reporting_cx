@echo off
echo.
echo ================================================
echo    Daily Work Update Generator
echo ================================================
echo.

where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Python not found. Please install Python 3.8+ from python.org
    echo Make sure to check "Add Python to PATH" during install.
    pause
    exit /b 1
)

if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Installing dependencies...
pip install -r requirements.txt -q --upgrade

if not exist "credentials.json" (
    echo.
    echo WARNING: credentials.json not found!
    echo   To enable Google Drive, download OAuth2 Desktop credentials
    echo   from console.cloud.google.com and save as credentials.json here.
    echo.
)

echo.
echo Ready! Opening at: http://localhost:5000
echo Press Ctrl+C to stop
echo.

python app.py
pause
