#Requires -Version 3.0
function Get-MrPipelineInput {

<#
.SYNOPSIS
    Retrieves parameters of a cmdlet that accept pipeline input.

.DESCRIPTION
    The Get-MrPipelineInput function examines the specified cmdlet and retrieves the parameters
    that accept pipeline input, either by value or by property name. The function allows filtering
    options and limits the number of records returned.

.PARAMETER Name
    The name of the cmdlet to examine. This parameter is mandatory.

.PARAMETER Option
    The selection mode for filtering the parameters. Defaults to 'Default'. Valid values are from
    the System.Management.Automation.WhereOperatorSelectionMode enumeration.

.PARAMETER Records
    The maximum number of records to return. Must be between 1 and 2147483647. Defaults to 2147483647.

.EXAMPLE
    Get-MrPipelineInput -Name Get-Process

.EXAMPLE
    Get-MrPipelineInput -Name Get-Process -Records 5

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Name,
        
        [System.Management.Automation.WhereOperatorSelectionMode]$Option = 'Default',
        
        [ValidateRange(1,2147483647)]
        [int]$Records = 2147483647
    )

    (Get-Command -Name $Name).ParameterSets.Parameters.Where({
        $_.ValueFromPipeline -or $_.ValueFromPipelineByPropertyName
    }, $Option, $Records).ForEach({
        [pscustomobject]@{
            ParameterName = $_.Name
            ParameterType = $_.ParameterType
            ValueFromPipeline = $_.ValueFromPipeline
            ValueFromPipelineByPropertyName = $_.ValueFromPipelineByPropertyName
        }
    })

}
