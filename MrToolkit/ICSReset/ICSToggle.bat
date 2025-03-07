@echo off
echo Disabling ICS...
powershell -ExecutionPolicy ByPass -command "Import-Module \Get-MrInternetConnectionSharing.ps1; Import-Module \Set-MrInternetConnectionSharing.ps1; Set-MrInternetConnectionSharing -InternetInterfaceName Wi-Fi -LocalInterfaceName Ethernet -Enabled $false; echo 'Enabling ICS...'; Set-MrInternetConnectionSharing -InternetInterfaceName Wi-Fi -LocalInterfaceName Ethernet -Enabled $true;"
echo ICS Enabled
