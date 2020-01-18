

#Exportable Function
function Set-MIAuthentication
{
	[CmdletBinding(DefaultParameterSetName = 'UsernameAndPassword')]
	Param (
		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
		[string]$Hostname,
		#[Parameter(Mandatory, ValueFromPipelineByPropertyName)]

		#[string]$APIKey,

		[Parameter(Mandatory, ParameterSetName = 'Credential')]
		[System.Management.Automation.PSCredential]$Credential = [System.Management.Automation.PSCredential]::Empty,
		[Parameter(Mandatory, ParameterSetName = 'UsernameAndPassword')]
		[string]$Username = "",
		[string]$Password = ""
	)
	Begin
	{
		Write-Verbose -Message '[Set-MIAuthentication] Begin'
		$url = "$Hostname/api/v2/ping"
	}
	Process
	{
		Write-Verbose -Message '[Set-MIAuthentication] Process'
		Switch ($PSCmdlet.ParameterSetName)
		{
			'UsernameAndPassword' {
				try
				{
					
					Write-Verbose -Message '[Connect-MIInstance] With Username and Password'
					
					$concateUserInfo = $userName + ":" + $password
					$restUserName = Get-BasicUserForAuth ($concateUserInfo)
					
					$global:MIAuthorizationMechanism = "UsernameAndPassword"
					$global:MIAuthorizationHeaderAuthorization = $restUserName
					
					$Headers = @{ 'Authorization' = "$restUserName" }
					
					$global:MIAuthorizationHeaders = $Headers
					$global:MIAuthorizationDefined = $true
					
					Write-Verbose -Message '[Set-MIAuthentication] Attempting to connect to the MobileIron Instance'
					$null = Invoke-RestMethod -Method Get -Uri $Url -Headers $Headers -ErrorAction Stop
					Write-Verbose -Message '[Set-MIAuthentication] Success connecting to the MobileIron Instance'
					#$Script:Hostname = $Hostname #set the Module Variable now
					#$Script:Headers = $Headers #set the Module Headers now
					
				}
				catch
				{
					Write-Verbose -Message '[Set-MIAuthentication] Failed to connect to the MobileIron Instance'
					Write-Error -Exception $_.exception -ErrorAction Stop
					
				}
			}
			'Credential'
			{
				try
				{
					
					Write-Verbose -Message '[Set-MIAuthentication] With Credentials'
					
					$encoding = [System.Text.Encoding]::UTF8.GetBytes($('{0}:{1}' -f $Credential.UserName, $Credential.GetNetworkCredential().Password))
					$EncodedUsernamePassword = [Convert]::ToBase64String($encoding)
					$Headers = @{ 'Authorization' = "Basic $($EncodedUsernamePassword)" }
					
					$global:MIAuthorizationMechanism = "Credential"
					$global:MIAuthorizationHeaders = $Headers
					$global:MIAuthorizationDefined = $true
					
					Write-Verbose -Message '[Set-MIAuthentication] Attempting to connect to the MobileIron Instance'
					$null = Invoke-RestMethod -Method Get -Uri $Url -Headers $Headers -ErrorAction Stop
					Write-Verbose -Message '[Set-MIAuthentication] Success connecting to the MobileIron Instance'
					
				}
				catch
				{
					Write-Verbose -Message '[Set-MIAuthentication] Failed to connect to the MobileIron Instance'
					Write-Error -Exception $_.exception -ErrorAction Stop
					
				}
			}
		}
	}
	End
	{
		Write-Verbose -Message '[Set-MIAuthentication] End'
	}
}