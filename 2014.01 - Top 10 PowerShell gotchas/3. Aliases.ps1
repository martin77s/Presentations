
gps s* | ? id -notin @(0,4)

Get-Process -Name s* | Where-Object { $_.ID -notin @(0,4) }



gsv | ? {$_.status -eq 'running'} |
    select *name,st* -exc s*e,ma* | 
        epcsv -en Unicode -not C:\Temp\run.csv


Get-Service | Where-Object {$_.status -eq 'running'} |
    Select-Object -Property Name, Displayname, Status |
        Export-Csv -Encoding Unicode -NoTypeInformation -Path C:\Temp\run.csv



New-Alias -Name du -Value Remove-ADUser
New-Alias -Name au -Value New-ADUser
New-Alias -Name mu -Value Move-ADObject


# Common exceptions
dir
cd
Where
Select
Sort
Group
