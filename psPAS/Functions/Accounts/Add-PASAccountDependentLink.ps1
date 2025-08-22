# .ExternalHelp psPAS-help.xml
function Add-PASAccountDependentLink {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('id')]
        [string]$AccountID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$DependentAccountID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$LinkedAccountID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$Index
    )
    BEGIN {
        #check minimum version (14.6 assumed)
        Assert-VersionRequirement -RequiredVersion 14.6
    }
    PROCESS {
        $body = @{ index = $Index; accountId = $LinkedAccountID } | ConvertTo-Json
        $uri = "$($psPASSession.ApiURI)/api/accounts/$AccountID/account-dependents/$DependentAccountID/link-accounts"
        
        Invoke-PASRestMethod -Uri $uri -Method POST -Body $body
    }
    END {}
}
