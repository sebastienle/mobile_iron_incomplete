#Get public and private function definition files.
$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

#Dot source the files
Foreach ($import in @($Public + $Private)) {
	Try
	{
		. $import.fullname
	}
	Catch
	{
		Write-Error -Message "Failed to import function $($import.fullname): $_"
	}
}

#Global Module Variables
##Environment Setup - Hostname and Proxy Info
##TO DO - ALLOW USER TO SAVE THEIR ENV INFO TO A JSON FILE AND LOAD IT AND NAME THEM
[boolean]$script:MIEnvironmentSet = $false
[string]$script:MIHostname = ""
[boolean]$script:MIUseProxy = $false
[string]$script:MIProxyServer = ""
[string]$script:MIProxyAuthentication = "" #ProxyUseDefaultCredentials

##Authentication
[boolean]$script:MIAuthorizationDefined = $false
[string]$script:MIAuthorizationMechanism = ""
[hashtable]$script:MIAuthorizationHeaders = @{ }


# Here I might...
# Read in or create an initial config file and variable
# Export Public functions ($Public.BaseName) for WIP modules
# Set variables visible to the module and its functions only

Export-ModuleMember -Function $Public.Basename
