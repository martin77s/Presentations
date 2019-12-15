
Stop-Service asd
qwerty
$ErrorActionPreference = "SilentlyContinue"

qwerty
Stop-Service asd


$ErrorActionPreference = "Continue"

Stop-Service asd -ErrorAction SilentlyContinue


Get-Service asd
if ($?) {
    "All OK"
}
else {
    "Not OK"
}


# Try + Catch + Finally

try 
{
    1/0
}
catch [DivideByZeroException]
{
    Write-Host "Divide by zero exception"
}
catch [System.Net.WebException],[System.Exception]
{
    Write-Host "Other exception"
}
finally
{
    Write-Host "cleaning up ..."
}




ping 127.0.0.1
$LASTEXITCODE

ping 127.0.0.1 -t
$LASTEXITCODE