function Get-MrExceptionType {

<#
.SYNOPSIS
    Retrieves the exception types from the most recent errors in the current PowerShell session.

.DESCRIPTION
    The Get-MrExceptionType function examines the $Error automatic variable and retrieves the
    exception types for the specified number of most recent errors. If no errors have occurred, it
    will display a warning message.The function defaults to retrieving the most recent error if the
    count is not specified.

.PARAMETER Count
    The number of recent errors to retrieve exception types for. Must be between 1 and 256.
    Defaults to 1.

.EXAMPLE
    Get-MrExceptionType

.EXAMPLE
    Get-MrExceptionType -Count 5

.INPUTS
    None

.OUTPUTS
    PSCustomObject

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [ValidateRange(1,256)]
        [int]$Count = 1
    )
    
    if ($Error.Count -ge 1) {

        if ($Count -gt $Error.Count) {
            $Count = $Error.Count
        }

        for ($i = 0; $i -lt $Count; $i++) {

            [PSCustomObject]@{
                ErrorNumber = "`$Error[$i]"
                ExceptionType = if ($Error[$i].exception) {$Error[$i].Exception.GetType().FullName}
            }

        }

    }
    else {
        Write-Warning -Message 'No errors have been generated for the current PowerShell session.'
    }
    
}
