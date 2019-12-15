Configuration MyFirstDSC
{
   # A Configuration block can have zero or more Node blocks
   Node "Web2012R2"
   {
        Archive myArchiveExample
        { 
            Ensure = "Present" # You can also set Ensure to "Absent"
            Path = "\\DC01\DSC\archive.zip"
            Destination = "C:\ExtractionPath"
        }
   }
} 

MyFirstDSC

notepad .\MyFirstDSC\Web2012R2.mof 

Start-DscConfiguration -Wait -Verbose -Path .\MyFirstDSC
