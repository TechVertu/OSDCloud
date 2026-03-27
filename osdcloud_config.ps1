Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5
Write-Host -ForegroundColor Cyan "Capturing hardware hash for Autopilot..."
Install-Script -Name Get-WindowsAutoPilotInfo -Force
Get-WindowsAutoPilotInfo -OutputFile "D:\AutopilotHash.csv"
Write-Host -ForegroundColor Green "Hash saved to USB - D:\AutopilotHash.csv"
Start-Sleep -Seconds 5
Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 25H2 -OSEdition Pro -OSLanguage en-us -OSLicense Retail -ZTI
Write-Host -ForegroundColor Green "Restarting in 20 seconds!"
Start-Sleep -Seconds 20
wpeutil reboot
