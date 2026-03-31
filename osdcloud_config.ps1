Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 25H2 -OSEdition Pro -OSLanguage en-gb -OSLicense Retail -ZTI

Write-Host -ForegroundColor Yellow "Device will reboot in 20 seconds..."
Start-Sleep -Seconds 20
wpeutil reboot
