#region Safety
throw "You're not supposed to hit F5"
#endregion"


$myObject1 = New-Object -TypeName PSObject
Add-Member -InputObject $myObject1 -MemberType NoteProperty Size -Value 'L'
Add-Member -InputObject $myObject1 -MemberType NoteProperty Color -Value 'Blue'
$myObject1


$myObject2 = New-Object -TypeName PSObject -ArgumentList @{
    Size = 'S'
    Color = 'Red'
}
$myObject2




$arr1 = @()
Get-Process p* | ForEach-Object {
    $p = New-Object -TypeName PSObject
    Add-Member -InputObject $p -MemberType NoteProperty -Name Name -Value $_.ProcessName
    Add-Member -InputObject $p -MemberType NoteProperty -Name Handles -Value $_.Handles
    Add-Member -InputObject $p -MemberType NoteProperty -Name ThreadsCount -Value $_.Threads.Count
    $arr1+= $p
}
$arr1



$arr2 = Get-Process p* | ForEach-Object {
    $p = New-Object -TypeName PSObject
    Add-Member -InputObject $p -MemberType NoteProperty -Name Name -Value $_.ProcessName
    Add-Member -InputObject $p -MemberType NoteProperty -Name Handles -Value $_.Handles
    Add-Member -InputObject $p -MemberType NoteProperty -Name ThreadsCount -Value $_.Threads.Count
    $p
}
$arr2



$arr3 = Get-Process p* | ForEach-Object {
    $p = New-Object -TypeName PSObject -Property @{
        Name = $_.ProcessName
        Handles = $_.Handles
        ThreadsCount = $_.Threads.Count
    }
    $p
}
$arr3



$arr4 = Get-Process p* | ForEach-Object {
    [pscustomobject]@{
        Name = $_.ProcessName
        Handles = $_.Handles
        ThreadsCount = $_.Threads.Count
    }
}
$arr4



$arr54 = Get-Process p* | Select-Object Name, Handles, 
    @{N='ThreadsCount'; E={$_.Threads.Count}}
$arr5