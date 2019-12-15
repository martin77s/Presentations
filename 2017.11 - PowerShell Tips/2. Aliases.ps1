#region Safety
throw "You're not supposed to hit F5"
#endregion"


gsv m* | ? {$_.Status -eq 4 } |
    select *name,st* -exc s*e,ma* | 
        epcsv -not C:\Temp\run.csv


		
		
Get-Service -Name m* | Where-Object {$_.Status -eq 'running'} |
    Select-Object -Property Name, Displayname, Status |
        Export-Csv -Encoding Unicode -NoTypeInformation -Path C:\Temp\run.csv



New-Alias -Name du -Value Remove-ADUser
New-Alias -Name au -Value New-ADUser
New-Alias -Name su -Value Set-ADUser
New-Alias -Name mu -Value Move-ADObject



function r { "Hello from my function"}
r

gal r


function Say-Hello {
    [Alias('Hello','Greet')]
    [CmdletBinding()]
    param()

    "Hello $ENV:USERNAME"
}

gal -def Say-Hello


# My exceptions
dir
cd
cls
