# .ExternalHelp psPAS-help.xml
function Remove-PASAccountDependentLink {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$AccountID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$DependentAccountID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$Index
    )
    BEGIN {
        #check minimum version (14.6 assumed)
        Assert-VersionRequirement -RequiredVersion 14.6
    }
    PROCESS {
        $uri = "$($psPASSession.ApiURI)/api/accounts/$AccountID/account-dependents/$DependentAccountID/link-accounts/$Index"
        
        if ($PSCmdlet.ShouldProcess($Index, 'Unlink Dependent Link Account')) {
            Invoke-PASRestMethod -Uri $uri -Method DELETE
        }
        
    }
    END {}
}
