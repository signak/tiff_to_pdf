Param($Ret)

$msgTable = Data {
    #culture="en-US"
    ConvertFrom-StringData -StringData @'
    msgCanceled = Canceled.
    msgCompleted = Completed.
    msgErrorRaised = Aborted due to an error.
    msgFinished = To exit, press [x] button or press Enter Key.
'@
}

# Import localized messages.
Import-LocalizedData -BindingVariable msgTable

if ($Ret -eq -1) {
    Write-Output $msgTable.msgCanceled
}
elseif ($Ret -eq 0) {
    Write-Output $msgTable.msgCompleted
}
else {
    Write-Output $msgTable.msgErrorRaised
}

Write-Output "`n$($msgTable.msgFinished)`n"
