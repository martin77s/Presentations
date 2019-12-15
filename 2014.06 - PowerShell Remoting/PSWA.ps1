# Install the role:
Get-WindowsFeature *PowerShell*
Install-WindowsFeature WindowsPowerShellWebAccess 


# To install the IIS Manager console as well, use the IncludeManagementTools switch parameter:
Install-WindowsFeature WindowsPowerShellWebAccess -IncludeManagementTools


# Install WebApplication:
Get-Command *pswa*
Install-PswaWebApplication -UseTestCertificate # Not recommended for Production environments. The test certificate expires in 90 days.


# Add Authorization Rules:
Get-PSSessionConfiguration | Select-Object Name

# To a user, on a specific computer, for a specific configuration
Add-PswaAuthorizationRule -UserName 'CONTOSO\martin' -ComputerName DC01 -ConfigurationName Microsoft.PowerShell -Force

# To a group, on all computers, for all configurations
Add-PswaAuthorizationRule -UserGroupName 'CONTOSO\Domain admins' -ComputerName * -ConfigurationName * -Force

# To everyone
Add-PswaAuthorizationRule * * *


# Web Access:
Start iexplore https://localhost/pswa

# Note that the hotkeys you might have been used to, no longer work in the web console


# PSWA Operational events in the Event Viewer:
Get-WinEvent -LogName Microsoft-Windows-PowerShellWebAccess/Operational

