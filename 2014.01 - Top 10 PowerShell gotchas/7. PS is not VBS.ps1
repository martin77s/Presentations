

# "Translating" WMI from vbs
$ErrorActionPreference = "SilentlyContinue"

$strfile=".\computers.txt"
$computers=Get-Content -Path $strfile
foreach ($computer in $computers) {
   Write-Host "querying $computer"
   $colitems=Get-WmiObject -ComputerName $computer -Class Win32_Operatingsystem 
   foreach ($item in $colitems) {
     Write-Host ("Computer    : " + $item.CSName)
     Write-Host ("OS          : " + $item.caption)
     Write-Host ("Architecture: " + $item.OSArchitecture)
     Write-Host ("Version     : " + $item.Version)
     Write-Host ("ServicePack : " + $item.ServicePackMajorVersion)
    }
}


# in PowerShell
Get-WmiObject Win32_OperatingSystem -ComputerName (Get-Content ".\computers.txt") | 
    Select-Object CSName, Caption, OSArchitecture, Version, ServicePackMajorVersion
