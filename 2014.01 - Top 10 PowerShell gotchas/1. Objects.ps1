
$d = Get-Date "05/11/1955"
$d


$d.ToLongDateString().Substring(0,($d.ToLongDateString().IndexOf(",")))

$arr = $d.ToLongDateString().Split(",")
$arr[0]

($d.ToLongDateString() -split ",")[0]

$d.DayOfWeek




$services = Get-Service
foreach ($service in $services) {
    Write-Host $service.Name $service.Status
}


Get-Service | Select-Object Name, Status


# Learn to use Get-Member!
Get-Service | Get-Member