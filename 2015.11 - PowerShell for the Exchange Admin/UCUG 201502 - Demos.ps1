
## The 3 best cmdlets
Get-Command -Verb Test
	Test-MAPIConnectivity
	
Get-Command -Noun Mailbox
Get-Command New-Mailbox -Syntax

Get-Help Get-MailboxStatistics
Get-Help Get-MailboxStatistics -Examples
Get-Help Get-MailboxStatistics -Parameters *

Get-Mailbox -Identity Administrator | Get-Member
Get-MailboxStatistics -Server EX1 | Get-Member

## FormatEnumerationLimit
Get-Mailbox -Identity Administrator | Select-Object AuditAdmin
$FormatEnumerationLimit
$FormatEnumerationLimit = -1
Get-Mailbox -Identity Administrator | Select-Object AuditAdmin


## Formatting is bad for your pipeline
Get-Mailbox | Select-Object DisplayName, Database, UseDatabaseQuotaDefaults | Export-Csv -NoTypeInformation -Path C:\Temp\so.csv
Get-Mailbox | Format-Table DisplayName, Database, UseDatabaseQuotaDefaults | Export-Csv -NoTypeInformation -Path C:\Temp\tf.csv


## "Filter left, format right"
Get-User -ResultSize Unlimited | Where-Object { $_.OrganizationalUnit -like '*Israel' }
Get-User -ResultSize Unlimited -OrganizationalUnit Israel

Measure-Command {
	Get-User -ResultSize Unlimited | Where-Object { $_.OrganizationalUnit -like '*Israel' }
}

Measure-Command {
	Get-User -ResultSize Unlimited -OrganizationalUnit Israel
}


Get-Mailbox -ResultSize Unlimited | Where-Object { $_.Name -like "transport*" }
Get-Mailbox -ResultSize Unlimited -Filter { Name -like "transport*" } 



## String Format
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$disk.FreeSpace
$disk.FreeSpace/1024/1024/1024
$disk.FreeSpace/1gb
'{0}' -f ($disk.FreeSpace/1gb)
'{0:N2}' -f ($disk.FreeSpace/1gb)
'{0:p}' -f ($disk.FreeSpace/$disk.Size)



## Implicit remoting in O365
$cred = Get-Credential 'martin@ucugil.onmicrosoft.com'
#Connect-MsolService -Credential $cred 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell/ -Credential $cred -Authentication Basic -AllowRedirection
$m = Import-PSSession $Session

Get-Mailbox
Invoke-Command -Session $Session -ScriptBlock { Get-Command }



## Hahstables

# "splatting"
New-Mailbox -UserPrincipalName confroom1010@contoso.com -Alias confroom1010 -Name "Conference Room 1010" -Room -EnableRoomMailboxAccount $true -RoomMailboxPassword (ConvertTo-SecureString -String P@ssw0rd -AsPlainText -Force)


$h = @{
	UserPrincipalName = 'confroom2020@contoso.com'
	Alias = 'confroom2020'
	Name = "Conference Room 2020"
	Room = $true
	EnableRoomMailboxAccount = $true
	RoomMailboxPassword = (ConvertTo-SecureString -String P@ssw0rd -AsPlainText -Force)
}
New-Mailbox @h


# Calculated objects (objects are deserialized in 0365)
Get-Mailbox | 
    Get-MailboxStatistics | 
        Sort-Object TotalItemSize –Descending | 
            Select-Object @{Name='User';Expression={$_.DisplayName}},
                @{Name='TotalSizeInMB';expression={$_.TotalItemSize.Value.ToMB()}},
                @{Name='Items';Expression={$_.ItemCount}},
                @{Name='StorageLimit';Expression={$_.StorageLimitStatus}}


