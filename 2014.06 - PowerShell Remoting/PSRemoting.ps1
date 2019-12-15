# What is NOT PowerShell Remoting
Get-Service -Name bits -ComputerName Web01
Get-Process -Name explorer -ComputerName Web01

# WinRM
Get-Service WinRM | Format-List

# Enable PSRemoting (Also with GPO or 'winrm qc')
Enable-PSRemoting 


$cred = Get-Credential
Get-WmiObject Win32_BIOS –ComputerName Web01
Get-WmiObject Win32_BIOS –ComputerName Web01 -Credential $cred

Export-CliXml -InputObject $cred -Path C:\Temp\cred.xml
notepad C:\Temp\cred.xml
$cred2 = Import-CliXml -Path C:\Temp\cred.xml




# CIM vs. WMI
Get-WmiObject Win32_BIOS –ComputerName DC01
Get-CimInstance Win32_BIOS –ComputerName DC01


$SessionOption = New-CimSessionOption -Protocol Dcom
$Session = New-CimSession -ComputerName DC01 -SessionOption $SessionOption
$Session | Get-CimInstance -Namespace root/cimv2 -ClassName Win32_BIOS


# 1:1, 1:Many
Invoke-Command -ComputerName Web01 -ScriptBlock { ipconfig }
Invoke-Command -ComputerName Web01, DC01 -ScriptBlock { hostname }


# Real world scenario:
Invoke-Command -ComputerName $myServers -ScriptBlock { Invoke-Expression 'cmd /c echo n| gpupdate /force' }


# Caveats
Invoke-Command -ComputerName Web01 -ScriptBlock { $d = Get-Date }
Invoke-Command -ComputerName Web01 -ScriptBlock { $d }

$d = Invoke-Command -ComputerName Web01 -ScriptBlock { Get-Date }
$d


# Serialized objects
$l_notepad = Get-Process -name notepad
$r_notepad = Invoke-Command -ComputerName Web01 -ScriptBlock { Get-Process -name notepad }

$l_notepad.GetType()
$r_notepad.GetType()


# Persistent remote session
$session = New-PSSession -ComputerName Web01
$session 

Invoke-Command -Session $session -ScriptBlock { $date = Get-Date }
Invoke-Command -Session $session -ScriptBlock { $date }

Invoke-Command -Session $session -FilePath C:\Temp\myScript.ps1


# Interactive remote session
Enter-PSSession -ComputerName Web01


# Import session
$session = New-PSSession –ComputerName DC01
Invoke-Command -Session $session -ScriptBlock { Import-Module ActiveDirectory }
Import-PSSession -Session $session -Module ActiveDirectory -Prefix r

Get-rADDomainController
Get-rADUser -Identity Administrator


# Configure WSMan
dir WSMan:\localhost\shell
dir WSMan:\localhost\Listener


# Constraining Sessions:
Get-PSSessionConfiguration
Register-PSSessionConfiguration -Name HelpDesk -ShowSecurityDescriptorUI


Register-PSSessionConfiguration -Name DelegatedEndpoint -ShowSecurityDescriptorUI -RunAsCredential (Get-Credential) -StartupScript C:\scripts\DelegatedEndpointStartupScript.ps1

