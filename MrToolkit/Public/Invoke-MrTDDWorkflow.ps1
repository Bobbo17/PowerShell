#Requires -Version 4.0 -Modules Pester
function Invoke-MrTDDWorkflow {

<#
.SYNOPSIS
    Implements a Test-Driven Development (TDD) workflow using Pester tests.

.DESCRIPTION
    The Invoke-MrTDDWorkflow function runs Pester tests in a specified directory and guides the
    user through a TDD workflow. The user is prompted to write failing unit tests and then write
    code to pass those tests. The process continues until the user indicates that the code is
    complete.

.PARAMETER Path
    The directory containing the Pester test scripts. This parameter must be a valid directory
    path. Defaults to the current directory.

.PARAMETER Seconds
    The number of seconds to wait between test runs when there are failing tests. Defaults to 30
    seconds.

.EXAMPLE
    Invoke-MrTDDWorkflow

.EXAMPLE
    Invoke-MrTDDWorkflow -Path C:\Tests -Seconds 15

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [ValidateScript({
          If (Test-Path -Path $_ -PathType Container) {
            $true
          }
          else {
            Throw "'$_' is not a valid directory."
          }
        })]
        [string]$Path = (Get-Location),

        [ValidateNotNullOrEmpty()]
        [int]$Seconds = 30
    )

    Add-Type -AssemblyName System.Windows.Forms
    Clear-Host

    while (-not $Complete) {       
    
        if ((Invoke-Pester -Script $Path -Show None -PassThru -OutVariable Results).FailedCount -eq 0) {

            if ([System.Windows.Forms.MessageBox]::Show('Is the code complete?', 'Status', 4, 'Question', 'Button2') -eq 'Yes') {
                $Complete = $true
            }
            else {
                $Complete = $False
                Write-Output "Write a failing unit test for a simple feature that doesn't yet exist."
            
                if ($psISE) {
                    [System.Windows.Forms.MessageBox]::Show('Click Ok to Continue')
                }
                else {
                    Write-Output 'Press any key to continue ...'
                    $Host.UI.RawUI.ReadKey('NoEcho, IncludeKeyDown') | Out-Null
                }

                Clear-Host
            }
              
        }
        else {
            Write-Output "Write code until unit test: '$(@($Results.TestResult).Where({$_.Passed -eq $false}, 'First', 1).Name)' passes"
            Start-Sleep -Seconds $Seconds
            Clear-Host
        }    

    }

}