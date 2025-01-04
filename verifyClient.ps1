$SiteCode = "DCC"
$SiteServer = "DCVWSCCMP1.w2k.bnm.gov.my"

do {
    # Prompt the user for device hostname
    $hostname = Read-Host "Enter hostname"

    # Determine device type based on hostname
    if ($hostname -like "PC*") {
        $deviceType = "PC"
    } elseif ($hostname -like "NB*") {
        $deviceType = "Notebook"
    } elseif ($hostname -like "SB*") {
        $deviceType = "Surface"
    } elseif ($hostname -like "TB*") {
        $deviceType = "Tablet"
    } else {
        $deviceType = "PC"
    }

    Write-Host "Checking compliance status for $hostname"
    Write-Host "Device type: $deviceType"

    # Convert hostname to uppercase
    $hostname = $hostname.ToUpper()

    <# Connect to SCCM WMI Namespace
    $SCCMWmiNamespace = "\\$SiteServer\root\SMS\site_$SiteCode"
    $SCCM = Get-WmiObject -Namespace $SCCMWmiNamespace -Class SMS_R_System -Filter "Name='$hostname'"

    if ($SCCM) {
        # Query the hardware inventory class
        $HardwareScan = Get-WmiObject -Namespace $SCCMWmiNamespace -Class SMS_G_System_WORKSTATION_STATUS -Filter "ResourceID='$($SCCM.ResourceID)'"
        if ($HardwareScan) {
            $LatestScanDate = $HardwareScan.LastHardwareScan
            Write-Host "Latest hardware scan date for $hostname: $LatestScanDate"
        } else {
            Write-Host "No hardware inventory data found for device $hostname."
        }

        # Query the OS build number
        $OSInfo = Get-WmiObject -Namespace $SCCMWmiNamespace -Class SMS_G_System_OPERATING_SYSTEM -Filter "ResourceID='$($SCCM.ResourceID)'"
        if ($OSInfo) {
            $BuildNumber = $OSInfo.BuildNumber
            Write-Host "OS Build Number for $hostname: $BuildNumber"
        } else {
            Write-Host "No OS information found for device $hostname."
        }
    } else {
        Write-Host "Device $hostname not found in SCCM."
    }#>

    # Ask user if they want to start again
    $restart = Read-Host "Do you want to check another hostname? (Y/N)"
} while ($restart -match '^[Yy]')
