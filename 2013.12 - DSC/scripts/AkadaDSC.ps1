Configuration AkadaDSC
{
    Node localhost
    {
        Registry myRegistryExample
        {
          Ensure = "Present"
          Key = "HKEY_LOCAL_MACHINE\SOFTWARE\myApplication"
          ValueName = "DatabaseServerName"
          ValueData = "SQLServer01.contoso.com"
        }
    }
} 

AkadaDSC

notepad .\AkadaDSC\localhost.mof 

$AnalyticLog = Get-WinEvent -ListLog Microsoft-Windows-DSC/Analytic
$AnalyticLog.IsEnabled = $true
$AnalyticLog.SaveChanges()



Start-DscConfiguration -Wait -Verbose -Path .\AkadaDSC

Get-WinEvent -LogName Microsoft-Windows-DSC/Analytic -Oldest | ogv

Get-DscConfiguration

Test-DscConfiguration

Test-DscConfiguration -Verbose


# Update Configuration and deploy new settings...

Restore-DscConfiguration

Test-DscConfiguration

Get-ChildItem -Path $env:SystemRoot\System32\Configuration

$AnalyticLog.IsEnabled = $false
$AnalyticLog.SaveChanges()
wevtutil clear-log Microsoft-Windows-DSC/Analytic

