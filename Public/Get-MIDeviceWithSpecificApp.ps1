

# Exportable Function
function Get-MIDeviceWithSpecificApp
{
	[CmdletBinding()]
	param (
		# Common parameters
		[parameter(Position = 0, Mandatory = $true)]
		[int]$AdminDeviceSpaceId,
		[parameter(Mandatory = $false)]
		[string]$AppVersion,
		# Parameter Sets - FOR FUTURE IMPLEMENTATION

		[parameter(Position = 1, Mandatory = $true, ParameterSetName = "ByInventoryId")]
		[int]$InventoryId,
		[parameter(Position = 1, Mandatory = $true, ParameterSetName = "ByAppName")]
		[string]$AppName,
		[parameter(Position = 2, Mandatory = $true, ParameterSetName = "ByAppName")]
		[parameter(Position = 2, Mandatory = $true, ParameterSetName = "ByAppId")]
		[string]$PlatformType,
		[parameter(Position = 1, Mandatory = $true, ParameterSetName = "ByAppId")]
		[string]$AppId
	)
	begin
	{
		Write-Verbose -Message '[Get-MIDeviceWithSpecificApp] Function Begin'
	}
	process
	{
		try
		{
			Write-Verbose -Message '[Get-MIDeviceWithSpecificApp] Function Process'
			
			$url = "$global:MIHostname/api/v2/appinventory/devices?adminDeviceSpaceId=$AdminDeviceSpaceId&"
			
			switch ($PsCmdlet.ParameterSetName)
			{
				"ByInventoryId" {
					$url = $url + "inventoryId=$InventoryId"
				}
				"ByAppName" {
					$url = $url + "appName=$AppName" + "&" + "platformType=$PlatformType"
				}
				"ByAppId" {
					$url = $url + "appId=$AppId" + "&" + "platformType=$PlatformType"
				}
			}
			
			Write-Verbose -Message '[Get-MIDeviceWithSpecificApp] Obtaining list of devices with the app'
			$resultFromRest = Invoke-RestMethod -Method Get -Uri $Url -Headers $global:MIAuthorizationHeaders -ErrorAction Stop
			Write-Verbose -Message '[Get-MIDeviceWithSpecificApp] Successfully obtained list of devices with the app'
			
			return $resultFromRest.results
		}
		catch
		{
			Write-Verbose -Message '[Get-MIDevice] Failed to get the list of devices with the app'
			Write-Error -Exception $_.exception -ErrorAction Stop
		}
	}
	end
	{
		# To do
		Write-Verbose -Message '[Get-MIDeviceWithSpecificApp] Function End'
	}
}