@echo off
@setlocal

cd /d "%~dps0"
powershell -ExecutionPolicy Unrestricted -File tiff_to_pdf.ps1

echo.
echo [x]ボタンでウィンドウを閉じるか、Enterキーを押すと終了します。
echo.
pause
