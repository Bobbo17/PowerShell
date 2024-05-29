function Get-MrPathSeparator {

<#
.SYNOPSIS
    Retrieves the platform-specific path separator character.

.DESCRIPTION
    The Get-MrPathSeparator function returns the character used to separate path strings in
    environment variables specific to the platform on which PowerShell is running. This is useful
    for scripts that need to handle paths in a cross-platform manner.

.EXAMPLE
    Get-MrPathSeparator

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

  [System.IO.Path]::PathSeparator
}