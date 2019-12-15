

#region Booleans
$x = $true
$y = "False"

$a = 0
$b = ''

cls
#endregion


$a -eq $b
$b -eq $a


$x
$y

$x -eq $y


2 + 5
2 + "5"
"2" + 5



$aa = 0
$bb = ''

$aa -eq $bb -and $aa.GetType() -eq $bb.GetType()
$aa -eq $bb -and $aa.Equals($bb)



# Operator Precedence

$true -or $true

$true -or $true -and $false

$true -or ($true -and $false)



# Boolenas are not strings

dir | Where-Object { $_.IsReadOnly -eq $true }

dir | Where-Object { $_.IsReadOnly }

dir | Where IsReadOnly # >= PSv3


dir | Where-Object { -not $_.IsReadOnly }




# Null vs. Nothing

$f = dir C:\Temp
foreach($file in $f) { "Item: $file" }
$f | foreach-object { "Item: $_" }



foreach($item in $blah) { "iteration" }
$blah | foreach-object { "iteration" }


function Get-Nothing {}
function Get-Null { $null }

Get-Nothing | foreach-object { "nothing" }
Get-Null | foreach-object { "null value" }



