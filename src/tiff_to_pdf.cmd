@echo off
@setlocal

cd /d "%~dps0"
powershell -ExecutionPolicy Unrestricted -File tiff_to_pdf.ps1

set RET=%ERRORLEVEL% 
echo.

IF %RET% equ -1 (
    echo �L�����Z�����܂����B
) ELSE IF %RET% equ 0 (
    echo �������������܂����B
) ELSE (
    echo �G���[�������������߁A�����𒆒f���܂����B
)

echo.
echo [x]�{�^���ŕ��邩�AEnter�L�[�������ƏI�����܂��B
pause >nul
