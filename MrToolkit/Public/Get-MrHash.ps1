function Get-MrHash {

<#
.SYNOPSIS
    Generates a hash value for a given string using the specified algorithm.

.DESCRIPTION
    The Get-MrHash function takes a string input and generates a hash value using either the MD5 or
    SHA1 algorithm. This can be useful for creating checksums or for storing secure representations
    of strings.

.PARAMETER String
    The input string to be hashed.

.PARAMETER Algorithm
    The hash algorithm to use. Valid values are 'MD5' and 'SHA1'. Defaults to 'MD5'.

.EXAMPLE
    Get-MrHash -String 'HelloWorld'

.EXAMPLE
    Get-MrHash -String 'HelloWorld' -Algorithm 'SHA1'

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [string]$String,
        
        [ValidateSet('MD5', 'SHA1')]        
        [string]$Algorithm = 'MD5'
    )

    switch ($Algorithm) {
        'MD5' {
            $hashAlgorithm = [System.Security.Cryptography.MD5]::Create()
        }
        'SHA1' {
            $hashAlgorithm = [System.Security.Cryptography.SHA1]::Create()
        }
    }

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($String)
    $hashBytes = $hashAlgorithm.ComputeHash($bytes)
    [BitConverter]::ToString($hashBytes) -replace '-', ''
}
