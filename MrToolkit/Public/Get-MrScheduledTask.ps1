#Requires -Version 3.0
function Get-MrScheduledTask {

<#
.SYNOPSIS
    Retrieves scheduled tasks from specified computers.

.DESCRIPTION
    The Get-MrScheduledTask function retrieves scheduled tasks from one or more specified computers.
    It can filter the tasks by name and can be run with alternate credentials if needed. The
    function uses the schtasks.exe utility to query the scheduled tasks and returns the results as
    custom objects.

.PARAMETER ComputerName
    The names of the computers from which to retrieve scheduled tasks. This parameter is mandatory.

.PARAMETER TaskName
    The name of the scheduled task to retrieve. If not specified, all scheduled tasks are retrieved.

.PARAMETER Credential
    The credentials to use for the remote connection. If not specified, the current user's
    credentials are used.

.EXAMPLE
    Get-MrScheduledTask -ComputerName localhost

.EXAMPLE
    Get-MrScheduledTask -ComputerName RemotePC -TaskName '\MyTask'

.EXAMPLE
    $Cred = Get-Credential
    Get-MrScheduledTask -ComputerName RemotePC1, RemotePC2 -Credential $Cred

.NOTES
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName,
        
        [string]$TaskName,

        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty
    )

    $Params = @{
        ComputerName = $ComputerName
    }

    if ($PSBoundParameters.Credential) {
        $Params.Credential = $Credential
    }

    Invoke-Command @Params {
        if ($Using:PSBoundParameters.TaskName) {
            schtasks.exe /Query /FO CSV /TN $Using:TaskName /V | ConvertFrom-Csv
        }
        else {
            schtasks.exe /Query /FO CSV /V | ConvertFrom-Csv
        }

    } -HideComputerName |
    Select-Object -Property @{label='ComputerName';expression={$_.hostname}},
                            @{label='Name';expression={$_.taskname -replace '^.*\\'}},
                            @{label='NextRunTime';expression={$_.'next run time'}},
                            Status,
                            @{label='LogonMode';expression={$_.'Logon Mode'}},
                            @{label='LastRunTime';expression={$_.'Last Run Time'}},
                            @{label='LastResult';expression={$_.'last result'}},
                            Author,
                            @{label='TaskToRun';expression={$_.'Task to Run'}},
                            Comment,
                            @{label='State';expression={$_.'Scheduled Task State'}},
                            @{label='RunAsUser';expression={$_.'Run as User'}},
                            @{label='ScheduleType';expression={$_.'Schedule Type'}},
                            @{label='StartTime';expression={$_.'start time'}},
                            @{label='StartDate';expression={$_.'Start Date'}},
                            Days

}
