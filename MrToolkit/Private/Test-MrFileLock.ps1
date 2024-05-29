function Test-MrFileLock {

<#
.SYNOPSIS
    Tests if a file is locked by another process.

.DESCRIPTION
    The Test-MrFileLock function checks if a specified file is currently locked by another process.
    If the file can be opened for reading and writing, it is not locked; otherwise, it is locked.

.PARAMETER Path
    The path to the file to be checked. This parameter is required and must be a valid file path.

.EXAMPLE
    Test-MrFileLock -Path C:\path\to\file.txt

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [ValidateScript({
          If (Test-Path -Path $_ -PathType Leaf) {
            $True
          }
          else {
            Throw "'$($_ -replace '^.*\\')' is not a valid file."
          }
        })]
        [string]$Path
    )

    try {
        $File = [System.IO.File]::Open("$Path", 'Open', 'Read', 'ReadWrite')
        if ($File) {
            $File.Close()
            $false            
        }

    }
    catch {
        Write-Verbose -Message "The file '$($Path -replace '^.*\\')' is locked by a process."
        $true
    }    

}
