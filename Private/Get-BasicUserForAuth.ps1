

function Get-BasicUserForAuth
{
	Param (
		[string]$func_username
	)
	begin
	{
		Write-Verbose -Message '[Get-BasicUserForAuth] Begin'
	}
	process
	{
		Write-Verbose -Message '[Get-BasicUserForAuth] Process'
		try
		{
			$userNameWithPassword = $func_username
			$encoding = [System.Text.Encoding]::ASCII.GetBytes($userNameWithPassword)
			$encodedString = [Convert]::ToBase64String($encoding)
			
			Return "Basic " + $encodedString
		}
		catch
		{
			Write-Verbose -Message '[Get-BasicUserForAuth] Failed to convert username to encoded string'
			Write-Error -Exception $_.exception -ErrorAction Stop
		}
		
	}
	end
	{
		Write-Verbose -Message '[Get-BasicUserForAuth] End'
	}
}