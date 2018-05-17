#region Scriptblock to execute at trigger

$actionScriptBlock = {

    # Note that the host process may already have exited by now

    $Event        = $EventArgs.NewEvent
    $ProcID       = $Event.ProcessID
    $StartTime    = [DateTime]::FromFileTime($Event.TIME_CREATED)
                 
    $ProcInfo     = Get-WmiObject -Query "SELECT * FROM Win32_Process WHERE ProcessId=$ProcID" -ErrorAction SilentlyContinue
    $CommandLine  = $ProcInfo.CommandLine
    $ProcessName  = $ProcInfo.Name
                 
    $FileName     = $Event.FileName
    $SMAVersion   = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($FileName).FileVersion
    $IsSuspicious = ([version]($SMAVersion)).Major -lt 10


    # Write-Warning / Write-Eventlog / Raise other alert

    Write-Warning @"
PowerShell host process started!

StartTime     : $StartTime
ProcessId     : $ProcID
ProcessName   : $ProcessName
CommandLine   : $CommandLine
SMAVersion    : $SMAVersion
IsSuspicious  : $IsSuspicious

"@

}
#endregion


#region Alert definition

# Trigger on any process that loads the PowerShell DLL - System.Management.Automation[.ni].dll
$eventRegisterArgs = @{
    Action = $actionScriptBlock
    SourceIdentifier = 'PowerShellHostProcessStarted'
    Query = 'SELECT * FROM Win32_ModuleLoadTrace WHERE FileName LIKE "%System.Management.Automation%.dll%"'
}

#endregion


#region Alert registration
$wmiEvent = Register-WmiEvent @eventRegisterArgs
# Unregister-Event $wmiEvent.Name
## Get-EventSubscriber -SourceIdentifier $wmiEvent.Name | Unregister-Event
#endregion
