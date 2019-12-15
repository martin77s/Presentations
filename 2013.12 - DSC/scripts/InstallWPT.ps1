Configuration InstallWPT
{
    PARAM($Nodes)

        Node $Nodes
        {
            Package WPTPackage
            { 
                Ensure = "Present"
                Name = "WPTx64"
                Path = "\\dc01\DSC\WPTx64-x86_en-us.msi"
                Arguments = "/qn /l* C:\myMsiInstall.log"
                ProductId = "{986EABFC-92F6-CECD-9E5A-B13CAC40BB1D}"
            }
        }
} 

InstallWPT -Nodes 'Web2012R2'

notepad .\InstallWPT\Web2012R2.mof 

Start-DscConfiguration -Wait -Verbose -Path .\InstallWPT
