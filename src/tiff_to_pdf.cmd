@echo off
@setlocal

cd /d "%~dps0"
powershell -ExecutionPolicy Unrestricted -File tiff_to_pdf.ps1

echo.
echo [x]�{�^���ŃE�B���h�E����邩�AEnter�L�[�������ƏI�����܂��B
echo.
pause
