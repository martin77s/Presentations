
$cred = Get-Credential CONTOSO\DnsOperator
$RemoteServer = '10.10.10.10'

$btnRemoteCmd_Click = {
	$txtResults.Text = 'Running: ' + $txtRemoteCmd.Text
	$res = Invoke-Command -ComputerName $txtComputerName.Text -ConfigurationName $txtJeaEP.Text -ScriptBlock ([scriptblock]::Create($txtRemoteCmd.Text)) -Credential $cred
	$txtResults.Text = $res | Format-Table -AutoSize | Out-String -Width 100
}

$btnWhoRemote_Click = {
	$txtWhoRemote.Text = Invoke-Command -ComputerName $txtComputerName.Text -ConfigurationName $txtJeaEP.Text -ScriptBlock { whoami.exe } -Credential $cred
	$res = Invoke-Command -ComputerName $txtComputerName.Text -ConfigurationName $txtJeaEP.Text -ScriptBlock {
		$PSSenderInfo | Select-Object ConnectedUser, RunAsUser, PSComputerName} -Credential $cred
	$txtResults.Text = $res | Format-Table -AutoSize | Out-String -Width 100
}

$btnWhoLocal_Click = {
	$txtWhoLocal.Text = whoami.exe
}

$btnExit_Click = {
	$MainForm.Close()
}


. (Join-Path $PSScriptRoot 'Form1.designer.ps1')
$MainForm.ShowDialog()