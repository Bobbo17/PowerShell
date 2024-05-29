function ConvertTo-MrHashTable {

<#
.SYNOPSIS
    Converts an array of PSObjects to an array of hashtables.

.DESCRIPTION
    The ConvertTo-MrHashTable function takes an array of PSObjects and converts each object into a
    hashtable. Each property of the PSObject becomes a key in the hashtable with the corresponding
    property value. This function can accept input directly from the pipeline.

.PARAMETER Object
    An array of PSObjects to be converted to hashtables. This parameter is mandatory and accepts
    input from the pipeline.

.EXAMPLE
    ConvertTo-MrHashTable -Object (Get-Process)

.EXAMPLE
    Get-Process -Name pwsh | ConvertTo-MrHashTable

.INPUTS
    PSObject

.OUTPUTS
    Hashtable

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [PSObject[]]$Object
    )
    PROCESS {
        foreach ($o in $Object) {
            $hashtable = @{}
            
            foreach ($p in Get-Member -InputObject $o -MemberType Property) {
                $hashtable.($p.Name) = $o.($p.Name)
            }

            Write-Output $hashtable
        }
    }
}