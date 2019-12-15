$dscProcessID = Get-WmiObject msft_providers | 
    Where-Object { $_.provider -like 'dsccore' } | 
        Select-Object -ExpandProperty HostProcessIdentifier 

Get-Process -Id $dscProcessID | Stop-Process -Force

Restart-Service WinRM