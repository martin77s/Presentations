#region Safety
throw "You're not supposed to hit F5"
#endregion"

#region Presets
$x = $true
$y = "False"

$a = 0
$b = ''

$Number = "100"
cls
#endregion


$a -eq $b
$b -eq $a

Get-Service -
$x
$y

$x -eq $y


$Number
$Number + 1




# Yikes Likes
$var = "[1234]"
$var -like "[1234]"
$var -like "*[1234567890]*"



# Null is not Nothing

$f = dir C:\Temp
foreach($file in $f) { "Item: $file" }
$f | foreach-object { "Item: $_" }


$blah = $null
foreach($item in $blah) { 'iteration' }
$blah | ForEach-Object { 'iteration' }




# Casting on the fly
'1.1.1.1', '2.2.2.2', '10.10.10.10', '1.2.3.4' | sort


'1.1.1.1', '2.2.2.2', '10.10.10.10', '1.2.3.4' | sort -Property { $_ -as [version] }


# Current culture vs. Independent culture

function Test-Date {
    param([datetime]$TheDate)
    $TheDate
}
Test-Date '1/2/2017'



Get-Date '01/02/2017'
[datetime]'01/02/2017'
'01/02/2017' -as [datetime]

[datetime]::ParseExact('01/02/2017', 'dd/MM/yyyy', $Null)



