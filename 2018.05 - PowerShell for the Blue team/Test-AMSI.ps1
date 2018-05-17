$base64 = "FHJ+YHoTZ1ZARxNgUl5DX1YJEwRWBAFQAFBWHgsFAlEeBwAACh4LBAcDHgNSUAIHCwdQAgALBRQ="
$bytes = [Convert]::FromBase64String($base64)
$string = -join ($bytes | % { [char] ($_ -bxor 0x33) })

iex $string


cmd /c pause
start ms-settings:windowsdefender

Write-Host @"
`n
Hint: Virus & Threat protection -> Scan History -> Allowed Threats
"@ -fore yellow