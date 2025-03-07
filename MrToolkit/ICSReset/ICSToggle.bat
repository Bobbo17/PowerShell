@echo off
echo Disabling ICS...
powershell -ExecutionPolicy ByPass -command "Import-Module C:\ICSReset\Get-MrICS.ps1; Import-Module C:\ICSReset\Set-MrICS.ps1; Set-MrInternetConnectionSharing -InternetInterfaceName Wi-Fi -LocalInterfaceName Ethernet -Enabled $false; echo Enabling ICS...; Set-MrInternetConnectionSharing -InternetInterfaceName Wi-Fi -LocalInterfaceName Ethernet -Enabled $true;"
echo ICS Enabled
