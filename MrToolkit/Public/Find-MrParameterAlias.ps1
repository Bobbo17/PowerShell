#Requires -Version 3.0
function Find-MrParameterAlias {

<#
.SYNOPSIS
    Finds parameter aliases for the specified cmdlet.

.DESCRIPTION
    The Find-MrParameterAlias function retrieves the parameter aliases for a given cmdlet.
    It can filter the parameters based on a specified parameter name pattern.

.PARAMETER CmdletName
    The name of the cmdlet for which to find parameter aliases. This parameter is mandatory.

.PARAMETER ParameterName
    The name of the parameter to filter the results by. Wildcards are allowed. Defaults to '*' to
    retrieve all parameters.

.EXAMPLE
    Find-MrParameterAlias -CmdletName Get-Process

.EXAMPLE
    Find-MrParameterAlias -CmdletName Get-Process -ParameterName Name

.INPUTS
    String

.OUTPUTS
    PSCustomObject

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$CmdletName,

        [ValidateNotNullOrEmpty()]
        [string]$ParameterName = '*'
    )
        
    (Get-Command -Name $CmdletName).parameters.values |
    Where-Object Name -like $ParameterName |
    Select-Object -Property Name, Aliases
}
