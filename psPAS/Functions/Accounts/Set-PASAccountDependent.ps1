# .ExternalHelp psPAS-help.xml
function Set-PASAccountDependent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$AccountID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$DependentAccountID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [string]$Name,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [hashtable]$PlatformDependentProperties = @{},
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [hashtable]$SecretManagement = @{},
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [string]$PlatformId,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [hashtable]$AdditionalProperties = @{}
    )
    BEGIN {
        #check minimum version (14.6 assumed)
        Assert-VersionRequirement -RequiredVersion 14.6
    }
    PROCESS {
        $uri = "$($psPASSession.BaseURI)/api/accounts/$AccountID/account-dependents/$DependentAccountID"
        
        $body = @{
            name = $Name
            platformDependentProperties = $PlatformDependentProperties
            secretManagement = $SecretManagement
            platformId = $PlatformId
        } + $AdditionalProperties

        $jsonBody = $body | ConvertTo-Json -Depth 5
        
        $result = Invoke-PASRestMethod -Uri $uri -Method PUT -Body $jsonBody
        if ($result) { $result.body }
    }
    END {}
}
