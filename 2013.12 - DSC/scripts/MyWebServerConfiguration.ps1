Configuration MyWebServerConfiguration
{
    param ($ComputerName, $WebsiteSourcePath)

    Node $ComputerName
    {

        WindowsFeature RoleIIS
        {
            Ensure = "Present"
            Name = "Web-Server"
        }


        WindowsFeature FeatureIISManager
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Console"
            DependsOn = "[WindowsFeature]RoleIIS"
        }


        WindowsFeature FeatureAspNet35
        {
            Ensure = "Present"
            Name = "Web-Asp-Net"
            Source = "D:\sources\sxs"
            DependsOn = "[WindowsFeature]RoleIIS"
        }


        WindowsFeature FeatureAspNet45
        {
            Ensure = "Present"
            Name = "Web-Asp-Net45"
            DependsOn = "[WindowsFeature]RoleIIS"
        }


        File FourthCoffeeWebSite
        {
            Ensure = "Present"
            Type = "Directory"
            Recurse = $true
            SourcePath = $WebsiteSourcePath
            DestinationPath = "C:\inetpub\wwwroot"
            DependsOn = "[WindowsFeature]RoleIIS"
        }


        Group WebSiteAdminsGroup
        {
            Ensure = "Present"
            GroupName = "WebSiteAdmins"
            MembersToInclude = @("Administrator")
            Description = "This group contains all WebSite Administrators"
        }


        Service AspNetStateService
        {
            Name = "aspnet_state"
            StartupType = "Automatic"
            State = "Running"
            DependsOn = "[WindowsFeature]FeatureAspNet35"
        }


        Script DatabasePermissions
        {
            DependsOn = "[File]FourthCoffeeWebSite"
            SetScript = {
                $acl = Get-Acl -Path "C:\inetpub\wwwroot\App_Data\bakery.sdf"
                $ace = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS", "FullControl", "Allow")
                $acl.SetAccessRule($ace)
                Set-Acl -Path "C:\inetpub\wwwroot\App_Data\bakery.sdf" -AclObject $acl
            }
            TestScript = { 
                $acl = Get-Acl -Path "C:\inetpub\wwwroot\App_Data\bakery.sdf"
                                (@($acl.Access | Where-Object { ($_.IdentityReference -eq 'BUILTIN\IIS_IUSRS') -and 
                                    ($_.FileSystemRights -eq 'FullControl') -and
                                        ($_.AccessControlType -eq 'Allow') }).Count -gt 0)
            }
            GetScript = { Get-Acl -Path "C:\inetpub\wwwroot\App_Data\bakery.sdf" }
        }


        Registry LicenseKey
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\FourthCoffee"
            ValueName = "License"
            ValueData = "ABCD-EF98-7654-3210"
        }


        Environment DebugFlag
        {
            Ensure = "Present" # You can also set Ensure to "Absent"
            Name = "FourthCoffee_DebugMode"
            Value = "0"
        }


        LocalConfigurationManager
        {
            RebootNodeIfNeeded = $true
            ConfigurationMode = "ApplyAndAutoCorrect" # Apply and Remediate configuration
            ConfigurationModeFrequencyMins = 15 # How frequently to recheck configuration
        }

     }
}



#region Create Configuration and Start
<#

Remove-Item -Path C:\Temp\MyWebServerConfiguration -Recurse -Force

New-Item -Path C:\Temp\MyWebServerConfiguration -ItemType Directory | Out-Null

MyWebServerConfiguration -ComputerName 'Web2012R2' -WebsiteSourcePath '\\DC01\DSC\FourthCoffeeWebSite' -OutputPath C:\Temp\MyWebServerConfiguration

Start-DscConfiguration -Path C:\Temp\MyWebServerConfiguration -Wait -Verbose -Force

#>
#endregion

