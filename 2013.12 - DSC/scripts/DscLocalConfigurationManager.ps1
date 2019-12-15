Get-DscLocalConfigurationManager



Configuration mySetLcmConfiguration
{
	Node "localhost"
	{
		LocalConfigurationManager
		{
			ConfigurationMode = "ApplyAndAutoCorrect"
			RefreshFrequencyMins = 30
			ConfigurationModeFrequencyMins = 60
			RefreshMode = "Push"
			RebootNodeIfNeeded = $true
		}
	}
}

mySetLcmConfiguration

Set-DscLocalConfigurationManager -Path .\mySetLcmConfiguration -Verbose

