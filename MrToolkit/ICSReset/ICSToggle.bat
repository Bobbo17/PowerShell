@echo off
echo Setting up Internet Connection Sharing for Credit Card Reader.
echo Disabling ICS: Do not close this window, it will close automatically...
powershell -ExecutionPolicy ByPass -command "Import-Module \Get-MrInternetConnectionSharing.ps1; Import-Module \Set-MrInternetConnectionSharing.ps1; Set-MrInternetConnectionSharing -InternetInterfaceName Wi-Fi -LocalInterfaceName Ethernet -Enabled $false; echo 'Enabling ICS...'; Set-MrInternetConnectionSharing -InternetInterfaceName Wi-Fi -LocalInterfaceName Ethernet -Enabled $true;"
echo ICS Enabled
