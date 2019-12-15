# 27.2.2018 - Microsoft Community Meeting - PowerShell Core

# Name     : Amir Granot
# Title    : DevOps Engineer and PowerShell Enthusiast
# Email    : amirgranot@outlook.com
# Blog     : https://granola.tech/

# Name     : Martin Schvartzman
# Title    : Senior Premier Field Engineer
# Email    : Martin.Schvartzman@microsoft.com
# Blog     : http://aka.ms/pstips

# Main Sources:
    # PowerShell GitHub Repository
    start 'https://github.com/PowerShell/PowerShell'
    # General Availability announcement (Features, Changes, ...)
    start 'https://blogs.msdn.microsoft.com/powershell/2018/01/10/powershell-core-6-0-generally-available-ga-and-supported/'

# Demo: Main differences between Windows PowerShell vs. PowerShell Core
    $PSVersionTable
    $PSVersionTable.PSEdition   # Core | Desktop
    $PSVersionTable.OS          # 
    $PSVersionTable.Platform    # Win32NT | Unix | MacOSX
    $IsWindows
    $IsMacOs
    $IsLinux

# Demo: New Feature on PowerShell Core
    # Start Job with & at the end of the line
    ping -t 8.8.8.8 &
    Get-Command &

    # Characters Range
    'a'..'z'
    'A'..'a'

    # Windows PowerShell
    Export-Csv -NoTypeInformation

    # PowerShell Core
    Export-Csv -IncludeTypeInformation

# Demo: Install PowerShell Core on Ubuntu 16
    # if curl is not installed
    sudo apt-get install curl -y

    # Import the public repository GPG keys
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    # Register the Microsoft Ubuntu repository
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
    # Update the list of products
    sudo apt-get update
    # Install PowerShell
    sudo apt-get install -y powershell

    # Start PowerShell
    pwsh

# Compatability Pack
    start 'https://github.com/PowerShell/WindowsPowerShellCompatibilityPack'

# PSRemoting over SSH
    start 'https://docs.microsoft.com/en-us/powershell/scripting/core-powershell/ssh-remoting-in-powershell-core?view=powershell-6'

# Demo: PSRemoting over SSH from Windows to Linux

    # Configure Windows (Client)
    # 1. Install the laset PowerShell Core build from GitHub
    # 2. Install Win32-OpenSSH (or OpenSSH_for_Windows)
    start 'https://github.com/PowerShell/Win32-OpenSSH/releases'
    # 3. Extract from ZIP
    # 4. Make sure ssh.exe is in PATH environment variable
    
    # Configure Ubuntu
    # 1. Install the latest PowerShell for Linux build from GitHub
    # 2. Install Ubuntu SSH as needed
    bash sudo apt install openssh-client openssh-server
    # 3. Edit the sshd_config file at location /etc/ssh
    #   3.1 Make sure password authentication is enabled: none PasswordAuthentication yes
    #   3.2 Add a PowerShell subsystem entry: none Subsystem powershell /usr/bin/pwsh -sshs -NoLogo -NoProfile
    #   3.3 Optionally enable key authentication: none PubkeyAuthentication yes
    # 7. Restart the sshd service: bash sudo service sshd restart
    # **** none - Do not write the word 'none' in the file. If the rest of the line already exists in the config file you can uncomment it.

    # Connect from Windows to Linux
    Enter-PSSession -HostName <IPAddress/ComputerName> -UserName <UserName>