

# Exportable Function
function Get-MIDevice
{
	[CmdletBinding(DefaultParameterSetName = 'WithNoParameter')]
	param (
		[parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[int]$AdminDeviceSpaceId,
		[parameter(ParameterSetName = "ByCompliance", Mandatory = $true)]
		[boolean]$Compliant,
		[parameter(ParameterSetName = "BySerialNumber", Mandatory = $true)]
		[string]$SerialNumber = "",
		[parameter(ParameterSetName = "ByUserId", Mandatory = $true)]
		[string]$UserId = ""
	)
	begin
	{
		Write-Verbose -Message '[Get-MIDevice] Function Begin'
	}
	process
	{
		Write-Verbose -Message '[Get-MIDevice] Function Process'
				
		$fields = Convert-ArrayFieldToCSVString -Array (Get-MIDeviceSearchFields -AdminDeviceSpaceId $AdminDeviceSpaceId) -ArrayField "Name"
		# Hard-coded stop gap because location_last_captured_at and location are NOT returned by Get-MIDeviceSearchFields
		# TO DO: Verify that the fields are not already present before adding them
		$fields = $fields + ",common.location_last_captured_at,common.location"
		
		$url = "$global:MIHostname/api/v2/devices?fields=$fields&"
		
		#URL querystring changes
		if ($AdminDeviceSpaceId -ne $null) { $url = "$url" + "adminDeviceSpaceId=$AdminDeviceSpaceId" + "&" }
		
		switch ($PsCmdlet.ParameterSetName)
		{
			"ByCompliance" {
				$query = """common.compliant""=""$Compliant"""
			}
			"BySerialNumber" {
				$query = """SerialNumber""=""$SerialNumber"""
			}
			"ByUserId" {
				$query = """user.user_id""=""$UserId"""
			}
			"WithNoParameter" {
				$query = ""
			}
			Default {
				$query = ""
			}
		}
		
		$url = "$url" + "query=$query" + "&"
		
		if ($url.Substring($url.Length - 1, 1) -eq "&")
		{
			$url = $url.Substring(0, $url.Length - 1)
		}
		
		Write-Verbose -Message '[Get-MIDevice] Running query for device'
		$resultFromRest = Invoke-RestMethod -Method Get -Uri $Url -Headers $global:MIAuthorizationHeaders -ErrorAction Stop
		Write-Verbose -Message '[Get-MIDevice] Query successfully executed'
		
		return $resultFromRest.Results
		
	}
	end
	{
		# To do
		Write-Verbose -Message '[Get-MIDevice] Function End'
	}
}