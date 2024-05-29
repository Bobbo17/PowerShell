#Requires -Version 3.0 
function Test-MrURL {

<#
.SYNOPSIS
    Tests the accessibility of a specified URL.

.DESCRIPTION
    The Test-MrURL function sends a web request to a specified URL and checks if the request is
    successful. The function can return a simple Boolean value indicating success or failure, or
    detailed information about the request.

.PARAMETER Uri
    The URL to test. This parameter is required.

.PARAMETER Detailed
    If specified, the function returns detailed information about the web request, including status
    code, status description, response URI, and server.

.EXAMPLE
    Test-MrURL -Uri http://www.example.com

.EXAMPLE
    Test-MrURL -Uri http://www.example.com -Detailed

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [string]$Uri,
        [switch]$Detailed
    )

    $CurrentErrorAction = $ErrorActionPreference

    $ErrorActionPreference = 'SilentlyContinue'
    $Result = Invoke-WebRequest -Uri $Uri -TimeoutSec 30
    $ErrorActionPreference = $CurrentErrorAction

    if ($Result.StatusCode -ne 200) {
        $false    
    }
    elseif (-not $Detailed) {
        $true
    }
    else {
        [pscustomobject]@{
            StatusDescription = $Result.StatusDescription
            StatusCode = $Result.StatusCode
            ResponseUri = $Result.BaseResponse.ResponseUri
            Server = $Result.BaseResponse.Server
        }
    }

}