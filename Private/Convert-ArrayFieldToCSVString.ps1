

function Convert-ArrayFieldToCSVString
{
	param (
		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
		[array]$Array,
		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, Position = 1)]
		[string]$ArrayField
	)
	begin
	{
		Write-Verbose -Message '[Convert-ArrayFieldToCSVString] Begin'
	}
	process
	{
		Write-Verbose -Message '[Convert-ArrayFieldToCSVString] Process'
		$returnValue = ""
		
		foreach ($value in $Array) {
			$returnValue = $returnValue + "," + $value.$ArrayField
		}
		
		#Remove leading and trailing commas caused by the ForEach loop
		$returnValue = $returnValue.Substring(1, $returnValue.Length - 1)
		return $returnValue
	}
	end
	{
		Write-Verbose -Message '[Convert-ArrayFieldToCSVString] End'
	}
}