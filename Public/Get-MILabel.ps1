

# Exportable Function
function Get-MILabel
{
	param (
		[parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[int]$AdminDeviceSpaceId
	)
	begin
	{
		Write-Verbose -Message '[Get-MILabel] Function Begin'
	}
	process
	{
		Write-Verbose -Message '[Get-MILabel] Function Process'
		
		try
		{
			$url = "$global:MIHostname/api/v2/labels/label_summary?adminDeviceSpaceId=$AdminDeviceSpaceId"
			
			Write-Verbose -Message '[Get-MILabel] Getting to get list of label'
			$resultFromRest = Invoke-RestMethod -Method Get -Uri $Url -Headers $global:MIAuthorizationHeaders -ErrorAction Stop
			Write-Verbose -Message '[Get-MILabel] Success getting to get list of label'
			
			return $resultFromRest.Results
		}
		catch
		{
			Write-Verbose -Message '[Get-MILabel] Failed to get list of label'
			Write-Error -Exception $_.exception -ErrorAction Stop
		}
	}
	end
	{
		Write-Verbose -Message '[Get-MILabel] Function End'
	}
}