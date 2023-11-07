# Set script version.
Set-Variable -name SCR_VER -value "1.0.1" -option Constant

# Load assembly.
Add-Type -Assembly System.Windows.Forms

# Set InfraView exe file path.
Set-Variable -name IVIEW -value "C:\Program Files\IrfanView\i_view64.exe" -option Constant

$msgTable = Data {
    #culture="en-US"
    ConvertFrom-StringData -StringData @'
    selectFolderDescription = Please select a folder. Folders under the selected folder will also be processed.
    confirmDialogCaption = Execution Confirmation
    confirmDialogMsg1 = Convert tif and tiff files in the following folders and their subfolders to pdf.
    confirmDialogMsg2 = Are you sure you want to run it?
    msgSearching = Searching in folders...
    msgFoundItemCount = Tiff files
    msgStartConvertion = Start conversion to PDF.
    msgWayToInterupt =  interrupt the process, use the Ctrl + C keys or close the window with the [x] button.
    msgConversion = converting
'@
}

# Import localized messages.
Import-LocalizedData -BindingVariable msgTable

# ----------------------------------------
# --- functions --------------------------
# Show FolderBrowserDialog for select target folder.
Function SelectTargetFolder {
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $msgTable.selectFolderDescription
    $result = $dialog.ShowDialog()

    if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
        return ""
    }

    return $dialog.SelectedPath
}

# Show dialog to confirm the continuation of conversion process.
Function ConfirmConversion {
    $caption = $msgTable.confirmDialogCaption
    $msg = -Join (
        $msgTable.confirmDialogMsg1,
        "`n`n",
        $targetFolderPath,
        "`n`n",
        $msgTable.confirmDialogMsg2
    )

    $buttonsType = "OKCancel"
    $iconType = "Question"
    $result = [System.Windows.Forms.MessageBox]::Show($msg, $caption, $buttonsType, $iconType);

    return $result
}
# ----------------------------------------

# ----------------------------------------
# --- main -------------------------------
Write-Output "`nTiff to PDF: Ver.$SCR_VER`n"

$targetFolderPath = SelectTargetFolder
if ($targetFolderPath -eq "") {
    exit -1
}

$confirm = ConfirmConversion
if ($confirm -ne [System.Windows.Forms.DialogResult]::OK) {
    exit -1
}

Write-Output $msgTable.msgSearching
$items = Get-ChildItem $targetFolderPath -File -Recurse -Include *.tif, *.tiff
$itemCount = $items.Count

Write-Output "`n$($msgTable.msgFoundItemCount) : $($itemCount)"
Write-Output "$($msgTable.msgStartConvertion)`n"
Write-Output "$($msgTable.msgWayToInterupt)`n"

foreach ($item in $items) {
    $srcName = $item.Name
    $srcPath = $item.FullName
    $dstPath = -Join ($item.Directory, '\', $item.BaseName, ".pdf")

    Write-Output "$($msgTable.msgConversion) : $($srcName)"
    Start-Process -FilePath $IVIEW -ArgumentList """$srcPath""", "/convert", """$dstPath""" -Wait
}

exit 0
# ----------------------------------------
