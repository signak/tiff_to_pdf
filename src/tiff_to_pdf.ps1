# Script Version.
Set-Variable -name SCR_VER -value "1.0.1" -option Constant

#名前空間指定
[void][System.Reflection.Assembly]::LoadWithPartialName("system.windows.forms")

# InfraViewの実行ファイルパス設定
Set-Variable -name IVIEW -value "C:\Program Files\IrfanView\i_view64.exe" -option Constant

#フォルダ参照ダイアログ
Function PickTargetFolder {
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "フォルダを選択してください。選択したフォルダ配下のフォルダ内も処理の対象になります。"
    $result = $dialog.ShowDialog()

    if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
        return ""
    }

    return $dialog.SelectedPath
}

Function ConfirmConversion {
    $caption = "実行確認"
    $msg = -Join("下記フォルダ内、および配下のサブフォルダ内のtif,tiffファイルをpdfに変換します。`n", $targetFolderPath, "`n`n実行してもよろしいですか？")
    
    $buttonsType = "OKCancel"
    $iconType = "Question"
    $result = [System.Windows.Forms.MessageBox]::Show($msg, $caption, $buttonsType, $iconType);

    return $result
}

Write-Output "`nTiff to PDF: Ver.$SCR_VER`n"

$targetFolderPath = PickTargetFolder
if ($targetFolderPath -eq "") {
    exit -1
}

$confirm = ConfirmConversion
if ($confirm -ne [System.Windows.Forms.DialogResult]::OK) {
    exit -1
}

Write-Output "フォルダ内を検索しています..."
$items = Get-ChildItem $targetFolderPath -File -Recurse -Include *.tif,*.tiff
$itemCount = $items.Count

Write-Output "`nTiffファイルが $itemCount 個みつかりました。"
Write-Output "PDFへの変換を開始します。`n"
Write-Output "中断する場合は、Ctrlキー＋Cキーで処理を中断するか、[x]ボタンでウィンドウを閉じてください。`n"

foreach ($item in $items) {
    $srcName = $item.Name
    $srcPath = $item.FullName
    $dstPath = -Join ($item.Directory, '\', $item.BaseName, ".pdf")

    Write-Output "変換中： $srcName"
    Start-Process -FilePath $IVIEW -ArgumentList """$srcPath""","/convert","""$dstPath""" -Wait
}

exit 0
