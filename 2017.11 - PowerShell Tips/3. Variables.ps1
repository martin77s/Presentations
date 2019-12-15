#region Safety
throw "You're not supposed to hit F5"
#endregion"


# Short, ad-hoc variables ok in an interactive console
$c = "localhost"
$l = "system"
$n = 10

Get-EventLog -logname $l -Newest $n -ComputerName $c



# Don't prefix the type to the variable names
$intNumber = 1
$strName = "Martin"



# Be strict!
Get-Service
Get-Service "BITS"


$serivce = "BITS"
Get-Service $service


Stop-Service $service
Get-Service $blahblah | Stop-Service -Whatif

Set-StrictMode -Version 1

dir
dir | ForEach-Object { $_.Length }


Set-StrictMode -Version 2
dir | ForEach-Object { $_.Length }

Set-StrictMode -Off
function add ($a, $b) {$a + $b}
add(3,4)

Set-StrictMode -Version 2
add(3,4)
