#region Safety
throw "You're not supposed to hit F5"
#endregion"

$task1 = { 
    Start-Sleep -Seconds 3; dir C:\
}
    
$task2 = { 
    Start-Sleep -Seconds 5; Get-Service BITS
}

$task3 = { 
    Start-Sleep -Seconds 4; 'Hello' 
}

# Sequential
Measure-Command {
	$results = & $task1 
	$results += & $task2 
	$results += & $task3 
}
$results
 

# Using jobs
Measure-Command {
    $jobs = $task1, $task2, $task3 | ForEach-Object {
	    Start-Job -ScriptBlock $_
    }
    $results2 = Get-Job | Wait-Job | Receive-Job
    Get-Job | Remove-Job -Force
}
$results2



# Using RSJobs
Find-Module PoshRSJob | Install-Module -Scope CurrentUser -Verbose

Get-Command -Module PoshRSJob

Measure-Command {
    $jobs = $task1, $task2, $task3 | ForEach-Object {
	    Start-RSJob -ScriptBlock $_
    }
    $results3 = Get-RSJob | Wait-RSJob | Receive-RSJob
    Get-RSJob | Remove-RSJob -Force
}
$results3




dir 'C:\Program Files\Microsoft*' -Directory | Start-RSjob -ScriptBlock {
    Param($Directory)
    $Sum = (Get-ChildItem $Directory.FullName -Recurse -Force -ErrorAction Ignore |
        Measure-Object -Property Length -Sum).Sum
    [pscustomobject]@{
        Path = $Directory.FullName
        SizeInMB = ([math]::round(($Sum/1MB),2))
    }
} | Out-Null
Get-RSJob | Wait-RSJob | Receive-RSJob
Get-RSJob | Remove-RSJob