#���O��Ԏw��
[void][System.Reflection.Assembly]::LoadWithPartialName("system.windows.forms")

#�t�H���_�Q�ƃ_�C�A���O
$dialog = New-Object System.Windows.Forms.FolderBrowserDialog
$dialog.Description = "�t�H���_��I�����Ă��������B�I�������t�H���_�z���̃t�H���_���������̑ΏۂɂȂ�܂��B"
$showdialog = $dialog.ShowDialog()

if ($showdialog -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Host "�L�����Z�����܂����B"
    exit
}

$targetFolderPath = $dialog.SelectedPath

$caption = "���s�m�F"
$msg = -Join("���L�t�H���_���A����єz���̃T�u�t�H���_����tif,tiff�t�@�C����pdf�ɕϊ����܂��B`n", $targetFolderPath, "`n`n���s���Ă���낵���ł����H")

$buttonsType = "OKCancel"
$iconType = "Question"
$result = [System.Windows.Forms.MessageBox]::Show($msg, $caption, $buttonsType, $iconType);

if ($result -ine "OK") {
    Write-Host "�L�����Z�����܂����B"
    exit
}

$iview = "C:\Program Files\IrfanView\i_view64.exe"

$items = Get-ChildItem $targetFolderPath -File -Recurse -Include *.tif,*.tiff
foreach ($item in $items) {
    $srcName = $item.Name
    $srcPath = $item.FullName
    $dstPath = -Join ($item.Directory, '\', $item.BaseName, ".pdf")

    Write-Host "�ϊ����F $srcName"
    Start-Process -FilePath $iview -ArgumentList """$srcPath""","/convert","""$dstPath""" -Wait
}
