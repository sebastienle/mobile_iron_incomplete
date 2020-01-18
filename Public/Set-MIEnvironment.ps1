
function Set-MIEnvironment {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Hostname,
		[switch]$UseProxy,
		[string]$ProxyServer,
		[string]$ProxyAuthentication
	)
	
	$global:MIHostname = $Hostname
	$global:MIEnvironmentSet = $true
	
	if ($UseProxy) {
		[boolean]$global:MIUseProxy = $true
		[string]$global:MIProxyServer = "$ProxyServer"
		[string]$global:MIProxyAuthentication = "$ProxyAuthentication"
	}
}