#Requires -Version 3.0
function Remove-MrSavedCredential {

<#
.SYNOPSIS
    Removes saved credentials for a specified target from the Windows Credential Manager.

.DESCRIPTION
    The Remove-MrSavedCredential function deletes saved credentials for a specified target from the
    Windows Credential Manager. It supports the ShouldProcess pattern, allowing for confirmation
    prompts and WhatIf scenarios.

.PARAMETER Target
    The target for which to remove saved credentials. This parameter is mandatory and accepts input
    from the pipeline by property name.

.EXAMPLE
    Remove-MrSavedCredential -Target 'example.com'

.EXAMPLE
    'example.com', 'anotherexample.com' | Remove-MrSavedCredential

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding(SupportsShouldProcess,
                   ConfirmImpact='Medium')]
    param (
        [Parameter(Mandatory,
                   ValueFromPipelineByPropertyName)]
        [string]$Target
    )

    PROCESS {
        if ($PSCmdlet.ShouldProcess($Target,'Delete')) {
            & "$env:windir\System32\cmdkey.exe" /delete $Target
        }
    }
    
}
