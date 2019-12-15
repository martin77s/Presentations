#region Safety
throw "You're not supposed to hit F5"
#endregion"


Get-Service | Where-Object { $_.Name -like "win*" }

Get-Service -Name win*


Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled } | Select-Object Name, IPAddress

Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "IPEnabled='True'" | Select-Object Name, IPAddress



Get-History -Count 1
perf



Measure-Command {Get-Service | where Status -eq 'running'}

Measure-Command {(Get-Service).Where({$_.Status -eq "Running"})}





Measure-Command {1..5000 | Where-Object {$_ % 5}}

Measure-Command {(1..5000).where({$_ % 5})}


$Services0 = Get-Service | Where-Object { $_.Status -eq "Running" }
$Services1 = Get-Service | Where-Object { $_.Status -ne "Running" }

$Services = (Get-Service) | Group-Object -Property Status
$Services[0].Count
$Services[1].Count


$Services = (Get-Service).Where({ $_.Status -eq "Running" }, 'Split')
$Services[0].Count
$Services[1].Count

(Get-Service).Where({ $_.Status -eq "Running" }, 'First')

(Get-Service).Where({ $_.Status -eq "Running" }, 'Last')


[int[]] $numbers = 1..10000
$scriptBlocks = @(
	{ $numbers | ForEach { $sum += $_ } -Begin { $sum = 0 } -End { $sum } },
	{ ($numbers | Measure-Object -sum).Sum },
	{ $sum = 0; foreach ($n in $numbers) { $sum += $n }; $sum },
	{ [Linq.Enumerable]::Sum($numbers) }
)

foreach($code in $scriptBlocks) {
	Measure-Command $code | 
		Select-Object @{N='Expression';E={$code}}, TotalMilliseconds
}


