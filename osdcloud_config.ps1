Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

Write-Host -ForegroundColor Cyan "Capturing hardware hash for Autopilot..."
$hash = Get-WmiObject -Namespace root/cimv2/mdm/dmmap -Class MDM_DevDetail_Ext01 -Filter "InstanceID='Ext' AND ParentID='./DevDetail'"
$csv = "Device Serial Number,Windows Product ID,Hardware Hash`n$((Get-WmiObject Win32_BIOS).SerialNumber),,$($hash.DeviceHardwareData)"
$csv | Out-File -FilePath "D:\AutopilotHash.csv" -Encoding utf8
Write-Host -ForegroundColor Green "Hash saved to USB - D:\AutopilotHash.csv"
Start-Sleep -Seconds 5

Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 25H2 -OSEdition Pro -OSLanguage en-gb -OSLicense Retail -ZTI

Write-Host -ForegroundColor Green "Restarting in 20 seconds!"
Start-Sleep -Seconds 20
wpeutil reboot
