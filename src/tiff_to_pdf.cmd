@echo off
@setlocal

cd /d "%~dps0"
powershell -ExecutionPolicy Unrestricted -File tiff_to_pdf.ps1

set RET=%ERRORLEVEL% 
echo.

IF %RET% equ -1 (
    echo キャンセルしました。
) ELSE IF %RET% equ 0 (
    echo 処理が完了しました。
) ELSE (
    echo エラーが発生したため、処理を中断しました。
)

echo.
echo [x]ボタンで閉じるか、Enterキーを押すと終了します。
pause >nul
