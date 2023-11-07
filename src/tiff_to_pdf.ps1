# Script Version.
Set-Variable -name SCR_VER -value "1.0.1" -option Constant

#���O��Ԏw��
[void][System.Reflection.Assembly]::LoadWithPartialName("system.windows.forms")

# InfraView�̎��s�t�@�C���p�X�ݒ�
Set-Variable -name IVIEW -value "C:\Program Files\IrfanView\i_view64.exe" -option Constant

#�t�H���_�Q�ƃ_�C�A���O
Function PickTargetFolder {
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "�t�H���_��I�����Ă��������B�I�������t�H���_�z���̃t�H���_���������̑ΏۂɂȂ�܂��B"
    $result = $dialog.ShowDialog()

    if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
        return ""
    }

    return $dialog.SelectedPath
}

Function ConfirmConversion {
    $caption = "���s�m�F"
    $msg = -Join("���L�t�H���_���A����єz���̃T�u�t�H���_����tif,tiff�t�@�C����pdf�ɕϊ����܂��B`n", $targetFolderPath, "`n`n���s���Ă���낵���ł����H")
    
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

Write-Output "�t�H���_�����������Ă��܂�..."
$items = Get-ChildItem $targetFolderPath -File -Recurse -Include *.tif,*.tiff
$itemCount = $items.Count

Write-Output "`nTiff�t�@�C���� $itemCount �݂���܂����B"
Write-Output "PDF�ւ̕ϊ����J�n���܂��B`n"
Write-Output "���f����ꍇ�́ACtrl�L�[�{C�L�[�ŏ����𒆒f���邩�A[x]�{�^���ŃE�B���h�E����Ă��������B`n"

foreach ($item in $items) {
    $srcName = $item.Name
    $srcPath = $item.FullName
    $dstPath = -Join ($item.Directory, '\', $item.BaseName, ".pdf")

    Write-Output "�ϊ����F $srcName"
    Start-Process -FilePath $IVIEW -ArgumentList """$srcPath""","/convert","""$dstPath""" -Wait
}

exit 0
