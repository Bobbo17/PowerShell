#Requires -Version 3.0
function Get-MrSavedCredential {

<#
.SYNOPSIS
    Retrieves saved credentials for a specified target.

.DESCRIPTION
    The Get-MrSavedCredential function uses the cmdkey.exe utility to retrieve saved credentials
    from the Windows Credential Manager for a specified target. The target string must not begin
    with a forward slash.

.PARAMETER Target
    The target for which to retrieve saved credentials. This parameter must not begin with a
    forward slash.

.EXAMPLE
    Get-MrSavedCredential -Target 'example.com'

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [ValidateScript({
            If ($_ -notmatch '^\/') {
                $True
            }
            else {
                Throw "$_ is not valid. Target cannot begin with a forward slash."
            }
        })]
        [string]$Target
    )

    $data = & "$env:windir\System32\cmdkey.exe" /list $Target |
            Select-String -Pattern '^\s+\S'

    for ($i=0;$i -lt $data.count;$i+=4) {

        [pscustomobject] @{
            Target = $data[$i] -replace '^.*=|^.*:\s|\s*$'
            Type = $data[$i+1] -replace '^.*:\s|\s*$'
            User = $data[$i+2] -replace '^.*:\s|\s*$'
            Persistence = $data[$i+3] -replace '^\s*|\s\S*$'
        }

    }

}