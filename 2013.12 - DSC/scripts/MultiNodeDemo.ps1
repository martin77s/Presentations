Configuration MultiNodeDemo
{
    Node Server01 
    {
        WindowsFeature TelnetClient 
        {
            Ensure = 'Present'
            Name = 'Telnet-Client'
        }
    }

    Node Web01 
    {
        WindowsFeature TelnetClient 
        {
            Ensure = 'Present'
            Name = 'Telnet-Client'
        }

        WindowsFeature WebServer 
        {
            Ensure = 'Present'
            Name = 'Web-Server'
        }
    }
}

### ### ### ### ### ### ### ### ### ###

Configuration MultiNodeWithDataDemo 
{

    Node $AllNodes.NodeName 
    {
        WindowsFeature TelnetClient 
        {
            Ensure = 'Present'
            Name = 'Telnet-Client'
        }
        Log LogMessage 
        {
            Message = "Installed telnet client: $($Node.LogMessage)"
            DependsOn = '[WindowsFeature]TelnetClient'
        }
    }

    Node $AllNodes.Where({ $_.NodeRole -eq 'Web' }).NodeName 
    {
        WindowsFeature WebServer 
        {
            Ensure = 'Present'
            Name = 'Web-Server'
        }
    }
}

$Nodes = @{
    AllNodes = @( 
        @{
            NodeName = '*'
            LogMessage = 'Message for all nodes'
        }
        @{ 
            NodeName = 'Server01.contoso.com'
            NodeRole = 'Server'
        }
        @{ 
            NodeName = 'Web01.contoso.com'
            NodeRole = 'Web'
            LogMessage = 'Message for Web servers only'
        }
    )
}


MultiNodeWithDataDemo -ConfigurationData $Nodes