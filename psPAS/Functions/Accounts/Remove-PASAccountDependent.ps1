# .ExternalHelp psPAS-help.xml
function Remove-PASAccountDependent {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$AccountID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$DependentAccountID
    )
    BEGIN {
        #check minimum version (14.6 assumed)
        Assert-VersionRequirement -RequiredVersion 14.6
    }
    PROCESS {
        $uri = "$($psPASSession.ApiURI)/api/accounts/$AccountID/account-dependents/$DependentAccountID"

        if ($PSCmdlet.ShouldProcess($DependentAccountID, 'Delete Dependent Account')) {
            Invoke-PASRestMethod -Uri $uri -Method DELETE
        }
    }
    END {}
}
