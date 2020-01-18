

# Exportable Function
function Get-MIDeviceSearchFields
{
	[CmdletBinding()]
	param (
		[parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[int]$AdminDeviceSpaceId
	)
	begin
	{
		Write-Verbose -Message '[Get-MIDeviceSearchFields] Function Begin'
	}
	process
	{
		try
		{
			Write-Verbose -Message '[Get-MIDeviceSearchFields] Function Process'
			
			$url = "$global:MIHostname/api/v2/devices/search_fields?adminDeviceSpaceId=$AdminDeviceSpaceId"
			
			Write-Verbose -Message '[Get-MIDeviceSearchFields] Obtaining list of fields'
			$resultFromRest = Invoke-RestMethod -Method Get -Uri $Url -Headers $global:MIAuthorizationHeaders -ErrorAction Stop
			Write-Verbose -Message '[Get-MIDevice] Successfully obtained list of fields'
			
			return $resultFromRest.results
		}
		catch
		{
			Write-Verbose -Message '[Get-MIDevice] Failed to get the list of fields'
			Write-Error -Exception $_.exception -ErrorAction Stop
		}
	}
	end
	{
		# To do
		Write-Verbose -Message '[Get-MIDeviceSearchFields] Function End'
	}
}