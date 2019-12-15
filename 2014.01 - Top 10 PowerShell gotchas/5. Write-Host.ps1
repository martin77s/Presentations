
Write-Host 1
Write-Output 1
Write 1
1

function Test1($Name) {
    "Hello $Name"
}


function Test2($Name) {
    Write-Host "Hello $Name"
}


Test1 -Name "Martin"
Test2 -Name "Martin"

$t1 = Test1 -Name "Martin"
$t2 = Test2 -Name "Martin"

$t1
$t2