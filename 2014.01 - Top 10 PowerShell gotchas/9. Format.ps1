
$a = Get-Process | Select-Object Name, ID, Handles

$b = Get-Process | Select-Object Name, ID, Handles | Format-Table -AutoSize


Get-Process | Select-Object Name, ID, Handles | Export-Csv -NoTypeInformation -Path C:\Temp\services1.csv

Get-Process | Select-Object Name, ID, Handles | Format-Table -AutoSize | Export-Csv -NoTypeInformation -Path C:\Temp\services2.csv




Get-Process | Select-Object Name, ID, Handles | Get-Member

Get-Process | Select-Object Name, ID, Handles | Format-Table -AutoSize | Get-Member





Get-Service | Where-Object { $_.Name -like "win*" }

Get-Service -Name win*


Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled } | Select-Object Name, IPAddress

Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "IPEnabled='True'" | Select-Object Name, IPAddress