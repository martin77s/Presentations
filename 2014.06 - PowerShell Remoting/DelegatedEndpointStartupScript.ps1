# DelegatedEndpointStartupScript.ps1
# -----------------------------------

# Create the functions that will be available to the user:
function StopBits { Stop-Service -Name 'BITS' }
function GetBits { Get-Service -Name 'BITS' }
function StartBits { Start-Service -Name 'BITS' }
function bye { Exit-PSSession }


# Create a list of commands you want to be available in this configuration
$arrAvailableCommands = @('StopBits', 'GetBits', 'StartBits', 'bye')
$arrAvailableCommands += @('Get-Service', 'Stop-Service', 'Start-Service', 'prompt', 'Out-Default', 'Clear-Host', 'Exit-PSSession', 'Measure-Object', 'Select-Object', 'Set-Location', 'Get-Command')

# Set private visibility for all other cmdlets
Get-Command | Where-Object { $arrAvailableCommands -notcontains $_.Name } | ForEach-Object { $_.Visibility = 'Private' }


# Disable external commands execution
$ExecutionContext.SessionState.Applications.Clear()

$ExecutionContext.SessionState.InvokeCommand.PostCommandLookupAction = {
    param($CommandName, $CommandLookupEventArgs)
    if ((Get-Command $CommandName).CommandType -eq 'Application') {
        Write-Verbose 'External Applications are not allowed!' -Verbose
        $CommandLookupEventArgs.CommandScriptBlock = { }.GetNewClosure()
    }
}

# Turn off the users ability to use language statements
$ExecutionContext.SessionState.LanguageMode = 'NoLanguage'