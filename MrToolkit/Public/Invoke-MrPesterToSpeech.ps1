#Requires -Version 3.0 -Modules Pester
function Invoke-MrPesterToSpeech {

<#
.SYNOPSIS
    Converts Pester test results to speech.

.DESCRIPTION
    The Invoke-MrPesterToSpeech function runs Pester tests and converts the results to speech.
    This can be useful for hands-free monitoring of test results.

.PARAMETER Script
    The path to the Pester test script to be executed.

.PARAMETER Voice
    The voice to use for the speech output. Defaults to the system default voice.

.PARAMETER Volume
    The volume level for the speech output. Valid values are between 0 and 100. Defaults to 100.

.PARAMETER Rate
    The rate of speech. Valid values are between -10 (slowest) and 10 (fastest). Defaults to 0.

.EXAMPLE
    Invoke-MrPesterToSpeech -Script C:\Tests\MyTest.Tests.ps1

.EXAMPLE
    Invoke-MrPesterToSpeech -Script C:\Tests\MyTest.Tests.ps1 -Voice 'Microsoft Zira Desktop'

.EXAMPLE
    Invoke-MrPesterToSpeech -Script C:\Tests\MyTest.Tests.ps1 -Rate -2

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [switch]$Quiet
    )

    $Params = @{}
    if ($PSBoundParameters.Quiet) {
        $Params.Quiet = $true
    }

    $Results = Invoke-Pester -PassThru @Params |
    Select-Object -ExpandProperty TestResult

    foreach ($Result in $Results) {
        Write-Output "The unit test named $($Result.Name) has $($Result.Result)." |
        Out-MrSpeech
    }
}