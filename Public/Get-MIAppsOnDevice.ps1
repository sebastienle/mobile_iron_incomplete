

#Exportable Function
function Get-MIAppsOnDevice
{
	param (
		$AdminDeviceSpaceId = 1,
		$DeviceUUIDs = "",
		$WifiMacs = ""
	)
	Process
	{
		
		$url = "$global:MIHostname/api/v2/devices/appinventory"
		
		if (($AdminDeviceSpaceId) -or ($DeviceUUIDs) -or ($WifiMacs))
		{
			$url = "$url" + "?"
		}
		
		if ($AdminDeviceSpaceId) { $url = "$url" + "adminDeviceSpaceId=$AdminDeviceSpaceId" + "&" }
		if ($DeviceUUIDs) { $url = "$url" + "deviceUuids=$DeviceUUIDs" + "&" }
		if ($WifiMacs) { $url = "$url" + "wifimacs=$WifiMacs" + "&" }
		
		if ($url.Substring($url.Length - 1, 1) -eq "&")
		{
			$url = $url.Substring(0, $url.Length - 1)
		}
		
		# Write-Host "Query for Apps on Device"
		# $url = "https://$global:MIHostname/api/v2/devices?adminDeviceSpace=1&count=50&offset=0&sortOrder=ASC&sortField=user.display_name&fields=user.display_name,common.current_phone_number,common.model,common.manufacturer,common.mdm_managed,common.platform_name,common.home_country_name,common.registration_date,common.last_connected_at,common.miclient_last_connected_at,common.owner,common.home_operator_name,common.language,common.creation_date,common.uuid,common.clientId,user.email_address,common.comment,user.user_id,common.storage_capacity,common.device_is_compromised,common.noncompliance_reasons,common.compliant,common.platform,common.quarantined,common.quarantined_reasons,common.id,android.attestation,ios.wakeup_status,common.status,common.device_space_name,common.background_status,common.data_protection_enabled,common.data_protection_reasons,common.device_admin_enabled,common.memory_capacity,common.memory_free,common.storage_capacity,common.storage_free,common.battery_level,common.client_name,common.client_version,ios.DataRoamingEnabled,common.locale,common.ethernet_mac,common.imei,common.imsi,common.ip_address,ios.iPhone ICCID,ios.iPhoneMAC_ADDRESS_EN0,ios.iPhone UDID,ios.iPhoneVERSION,ios.DeviceName,common.os_version,android.afw_capable,android.registration_status&labelId=-1&query=samsung&page=1&start=0&limit=50"
		# Note: Contrary to the PDF doc, the argument is NOT adminDeviceSpace BUT adminDeviceSpaceId
		# $url = "https://$global:MIHostname/api/v2/devices?adminDeviceSpaceId=1&query=&fields=user.display_name,common.current_phone_number,common.model,common.manufacturer"
		
		$resultFromRest = Invoke-RestMethod -Method Get -Uri $Url -Headers $global:MIAuthorizationHeaders -ErrorAction Stop
		Write-Verbose -Message '[Get-MIDevice] '
		
		return $resultFromRest.Results.appInventory
		
	}
}