@echo off
@setlocal

cd /d "%~dps0"
powershell -ExecutionPolicy Unrestricted -File tiff_to_pdf.ps1

set RET=%ERRORLEVEL%
echo.

powershell -ExecutionPolicy Unrestricted -File show_result_msg.ps1 -Ret %RET%

pause >nul
