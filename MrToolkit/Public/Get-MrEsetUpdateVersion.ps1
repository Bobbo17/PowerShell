function Get-MrEsetUpdateVersion {

<#
.SYNOPSIS
    Retrieves the ESET product update version information from specified computers.

.DESCRIPTION
    The Get-MrEsetUpdateVersion function connects to one or more specified computers and retrieves
    ESET product update version information from the registry. The function can be run with
    alternate credentials if needed.

.PARAMETER ComputerName
    The names of the computers to retrieve the ESET update version information from. Defaults to
    the local computer if not specified.

.PARAMETER Credential
    The credentials to use for the remote connection. If not specified, the current user's
    credentials are used.

.EXAMPLE
    Get-MrEsetUpdateVersion

.EXAMPLE
    Get-MrEsetUpdateVersion -ComputerName RemotePC

.EXAMPLE
    $Cred = Get-Credential
    Get-MrEsetUpdateVersion -ComputerName RemotePC1, RemotePC2 -Credential $Cred

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $env:COMPUTERNAME,
        
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty
    )

    $Params = @{}
    if ($PSBoundParameters.Credential){
        $Params.Credential = $Credential
    }

    $Results = Invoke-Command -ComputerName $ComputerName {
        Get-ItemProperty -Path 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info' 2>&1 
    } @Params

    foreach ($Result in $Results) {
        [pscustomobject]@{
            ComputerName = $Result.PSComputerName
            ProductName = $Result.ProductName
            ScannerVersion = $Result.ScannerVersionId
            LastUpdate = if ($Result.ScannerVersion) {([datetime]::ParseExact($Result.ScannerVersion -replace '^.*\(|\)', 'yyyyMMdd', $null)).ToShortDateString()}
        }
    }
    
}
