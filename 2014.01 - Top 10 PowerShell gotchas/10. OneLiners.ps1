

# "Death by one-liners"
Get-WmiObject -Namespace root\cimv2 -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | Sort-Object -Property DeviceID | Select-Object @{Name='Drive'; Expression={$_.DeviceID}}, VolumeName, Size, FreeSpace, @{Name='PercentageFree'; Expression={"{0:p}" -f ($_.FreeSpace/$_.Size)}}



$Disks = Get-WmiObject -Namespace root\cimv2 -Class Win32_LogicalDisk 
$HardDisks = $Disks | Where-Object { $_.DriveType -eq 3 }
$SortedHardDisks = $HardDisks | Sort-Object -Property DeviceID 
$MyDisksReport = $SortedHardDisks | Select-Object @{Name='Drive'; Expression={$_.DeviceID}}, VolumeName, Size, FreeSpace, @{Name='PercentageFree'; Expression={"{0:p}" -f ($_.FreeSpace/$_.Size)}}
$MyDisksReport 




Get-WmiObject -Namespace root\cimv2 -Class Win32_LogicalDisk | 
    Where-Object { $_.DriveType -eq 3 } | 
        Sort-Object -Property DeviceID | 
            Select-Object @{Name='Drive'; Expression={$_.DeviceID}}, VolumeName, Size, FreeSpace, 
                    @{Name='PercentageFree'; Expression={"{0:p}" -f ($_.FreeSpace/$_.Size)}}
