

# Exportable Function
function Get-MISpace
{
	[CmdletBinding(DefaultParameterSetName = "ById")]
	param (
		[parameter(Position = 0, ParameterSetName = "ById", Mandatory = $true, ValueFromPipeline = $true)]
		[string]$AdminDeviceSpaceId,
		[parameter(Position = 0, ParameterSetName = "ByMine")]
		[Switch]$Mine,
		[parameter(Position = 1, ParameterSetName = "ById", Mandatory = $false)]
		[Switch]$ExcludeDeviceCount
	)
	begin
	{
		# To do
		Write-Verbose -Message '[Get-MISpace] Function Begin'
		[string]$url = ""
		[string]$urlById = "$global:MIHostname/api/v2/device_spaces?"
		[string]$urlByMine = "$global:MIHostname/api/v2/device_spaces/mine"
	}
	process
	{
		Write-Verbose -Message '[Get-MISpace] Function Process'
		
		switch ($PsCmdlet.ParameterSetName)
		{
			"ById" {
				$url = $urlById + "adminDeviceSpaceId=$AdminDeviceSpaceId"
				if ($ExcludeDeviceCount) { $url = "$url" + "&excludeDeviceCount=true" }
			}
			"ByMine" {
				$url = $urlByMine
			}
		}
		
		$resultFromRest = Invoke-RestMethod -Method Get -Uri $Url -Headers $global:MIAuthorizationHeaders -ErrorAction Stop
		return $resultFromRest.Results
	}
	end
	{
		# To do
		Write-Verbose -Message '[Get-MISpace] Function End'
	}
}