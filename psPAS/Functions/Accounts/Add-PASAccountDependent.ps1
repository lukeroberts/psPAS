# .ExternalHelp psPAS-help.xml
function Add-PASAccountDependent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$AccountID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$Name,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [hashtable]$PlatformDependentProperties = @{},
        [parameter(Mandatory = $false,ValueFromPipelinebyPropertyName = $true)]
		[boolean]$automaticManagementEnabled=$true,
		[Parameter(Mandatory = $false,ValueFromPipelinebyPropertyName = $true)]
		[string]$manualManagementReason,
        [parameter(Mandatory = $false,ValueFromPipelinebyPropertyName = $true)]
		[boolean]$disableParentAutomaticManagement=$false,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$PlatformId,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [hashtable]$AdditionalProperties = @{}
    )
    BEGIN {
        #check minimum version (14.6 assumed)
        Assert-VersionRequirement -RequiredVersion 14.6
    }
    PROCESS {
        $uri = "$($psPASSession.ApiURI)/api/accounts/$AccountID/account-dependents"
        
        $SecretManagement = @{
            automaticManagementEnabled = $automaticManagementEnabled
            manualManagementReason = $manualManagementReason
            disableParentAutomaticManagement = $disableParentAutomaticManagement
        }

        $body = @{
            name = $Name
            platformDependentProperties = $PlatformDependentProperties
            secretManagement = $SecretManagement
            platformId = $PlatformId
        } + $AdditionalProperties
        $jsonBody = $body | ConvertTo-Json -Depth 5
        
        $result = Invoke-PASRestMethod -Uri $uri -Method POST -Body $jsonBody
        if ($result) { $result }
    }
    END {}
}
