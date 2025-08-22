# .ExternalHelp psPAS-help.xml
function Get-PASAccountDependent {
    [CmdletBinding(DefaultParameterSetName = 'ByAccount')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ByAccount')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ById')]
        [Alias('id')]
        [string]$AccountID,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ById')]
        [string]$DependentAccountID,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ByAccount')]
        [string]$keyword,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ByAccount')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ById')]
        [boolean]$extendedDetails,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ByAccount')]
        [int]$limit = 20,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ByAccount')]
        [int]$offset = 0
    )

    BEGIN {
        #check minimum version (14.6 assumed)
        Assert-VersionRequirement -RequiredVersion 14.6
    }
    PROCESS {
        if ($PSCmdlet.ParameterSetName -eq 'ByAccount') {
            # Use Get-PASParameter to filter and build query string
            $queryParams = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID
            $queryString = $queryParams | ConvertTo-QueryString

            $uri = "$($psPASSession.ApiURI)/api/accounts/$AccountID/account-dependents"
            if ($null -ne $queryString) { $uri += "?$queryString" }

            $result = Invoke-PASRestMethod -Uri $uri -Method GET
            if ($result) { $result.accountDependents }
        } 
        elseif ($PSCmdlet.ParameterSetName -eq 'ById') {
            $queryParams = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, DependentAccountID
            $queryString = $queryParams | ConvertTo-QueryString

            $uri = "$($psPASSession.ApiURI)/api/accounts/$AccountID/account-dependents/$DependentAccountID"
            if ($null -ne $queryString) { $uri += "?$queryString" }

            $result = Invoke-PASRestMethod -Uri $uri -Method GET
            if ($result) { $result }
        }
    }
    END {}
}
