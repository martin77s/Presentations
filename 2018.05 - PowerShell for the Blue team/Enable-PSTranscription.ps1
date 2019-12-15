Configuration EnablePSTranscription {

    Param(
        [string] $TranscriptionPath = 'C:\myPSTranscripts',
        [ValidateRange(1,365)] [int] $RetentionTimeInDays = 14,
        [ValidateRange(1,1024)] [int] $EventLogSizeInMB = 50
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost {

        Registry EnableScriptBlockLogging {
            Key       = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
            ValueName = 'EnableScriptBlockLogging'
            ValueData = 1
            ValueType = 'String'
            Ensure    = 'Present'
        }


        Registry EnableTranscripting {
            Key       = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription'
            ValueName = 'EnableTranscripting'
            ValueData = 1
            ValueType = 'String'
            Ensure    = 'Present'
        }


        Registry IncludeInvocationHeader {
            Key       = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription'
            ValueName = 'IncludeInvocationHeader'
            ValueData = 1
            ValueType = 'String'
            Ensure    = 'Present'
        }


        Registry TranscriptionPath {
            Key       = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription'
            ValueName = 'OutputDirectory'
            ValueData = $TranscriptionPath
            ValueType = 'String'
            Ensure    = 'Present'
        }


        Script PowerShellLogSize {
            GetScript = {
                Return @{
                    Result = Get-WinEvent -ListLog Microsoft-Windows-PowerShell/Operational | Out-String
                }
            }
            TestScript = {
                $Log = Get-WinEvent -ListLog Microsoft-Windows-PowerShell/Operational
                If ($Log.LogMode -ne 'Circular' -or $Log.MaximumSizeInBytes -lt ($using:EventLogSizeInMB * 1MB)) {
                    Write-Verbose 'Event log [Microsoft-Windows-PowerShell/Operational] is NOT in desired state.'
                    Return $false
                } Else {
                    Write-Verbose 'Event log [Microsoft-Windows-PowerShell/Operational] is in desired state.'
                    Return $true
                }
            }
            SetScript = {
                Write-Verbose 'Applying settings to event log [Microsoft-Windows-PowerShell/Operational].'
                wevtutil set-log Microsoft-Windows-PowerShell/Operational /retention:false /maxsize:$($using:EventLogSizeInMB * 1MB)
            }
        }

        if($TranscriptionPath -notmatch '^\\\\') {

            File TranscriptsDirectory {
                DestinationPath = $TranscriptionPath
                Type            = 'Directory'
                Ensure          = 'Present'
            }

            Script TranscriptsDirectoryPermissions {
                GetScript = {
                    $acl = Get-Acl $using:TranscriptionPath
                    Return @{
                        Result = $acl.Sddl
                    }
                }
                TestScript = {
                    $acl = Get-Acl $using:TranscriptionPath
                    Write-Verbose "Transcript directory permissions: $($acl.Sddl)"
                    If ($acl.Sddl -ne 'O:BAG:DUD:PAI(D;OICIIO;FA;;;CO)(A;OICI;0x100196;;;WD)(A;OICI;FA;;;BA)') {
                        Write-Verbose 'Transcript directory permissions are NOT in desired state'
                        Return $false
                    } Else {
                        Write-Verbose 'Transcript directory permissions are in desired state'
                        Return $true
                    }
                }
                SetScript = {
                    Write-Verbose 'Applying transcript directory permissions'
                    # Remove inherited permissions
                    # Allow Administrators full control
                    # Allow Everyone Write and ReadAttributes
                    # Deny CreatorOwner Full Control
                    $acl = Get-Acl $using:TranscriptionPath
                    $acl.SetSecurityDescriptorSddlForm('O:BAG:DUD:PAI(D;OICIIO;FA;;;CO)(A;OICI;0x100196;;;WD)(A;OICI;FA;;;BA)')
                    $acl | Set-Acl $using:TranscriptionPath -Verbose
                }
                DependsOn = '[File]TranscriptsDirectory'
            }

            Script TranscriptsDirectoryTrim {
                GetScript = {
                    Return @{
                        Result = $using:TranscriptionPath
                    }
                }
                TestScript = {
                    $ErrorActionPreference = 'Stop'
                    Try {
                        $OldContent = Get-ChildItem $using:TranscriptionPath -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays($using:TranscriptDays * -1)}
                    }
                    Catch {
                        Write-Warning 'Access denied to some of the transcript files'
                    }
                    If ($OldContent) {
                        Write-Verbose "Transcript directory contains content older than $($using:TranscriptDays) days"
                        Return $false
                    } Else {
                        Write-Verbose "Transcript directory DOES NOT contain content older than $($using:TranscriptDays) days"
                        Return $true
                    }
                }
                SetScript = {
                    $ErrorActionPreference = 'Stop'
                    Try {
                        Get-ChildItem $using:TranscriptionPath -Recurse |
                            Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays($using:TranscriptDays * -1)} |
                                Remove-Item -Force -Confirm:$false -Verbose
                    }
                    Catch {
                        Write-Warning 'Access denied to some of the transcript files'
                    }
                }
                DependsOn = '[File]TranscriptsDirectory'
            }
        }
    }
}

break
cd C:\Temp
EnablePSTranscription

Start-DscConfiguration -Wait -Verbose -Force -Path .\EnablePSTranscription