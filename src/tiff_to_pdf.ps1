#名前空間指定
[void][System.Reflection.Assembly]::LoadWithPartialName("system.windows.forms")

#フォルダ参照ダイアログ
$dialog = New-Object System.Windows.Forms.FolderBrowserDialog
$dialog.Description = "フォルダを選択してください。選択したフォルダ配下のフォルダ内も処理の対象になります。"
$showdialog = $dialog.ShowDialog()

if ($showdialog -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Host "キャンセルしました。"
    exit
}

$targetFolderPath = $dialog.SelectedPath

$caption = "実行確認"
$msg = -Join("下記フォルダ内、および配下のサブフォルダ内のtif,tiffファイルをpdfに変換します。`n", $targetFolderPath, "`n`n実行してもよろしいですか？")

$buttonsType = "OKCancel"
$iconType = "Question"
$result = [System.Windows.Forms.MessageBox]::Show($msg, $caption, $buttonsType, $iconType);

if ($result -ine "OK") {
    Write-Host "キャンセルしました。"
    exit
}

$iview = "C:\Program Files\IrfanView\i_view64.exe"

$items = Get-ChildItem $targetFolderPath -File -Recurse -Include *.tif,*.tiff
foreach ($item in $items) {
    $srcName = $item.Name
    $srcPath = $item.FullName
    $dstPath = -Join ($item.Directory, '\', $item.BaseName, ".pdf")

    Write-Host "変換中： $srcName"
    Start-Process -FilePath $iview -ArgumentList """$srcPath""","/convert","""$dstPath""" -Wait
}
