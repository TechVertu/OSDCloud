Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5
Write-Host -ForegroundColor Cyan "Capturing hardware hash for Autopilot..."
$AutopilotDir = (Get-PSDrive -PSProvider FileSystem | Where-Object {Test-Path "$($_.Root)Autopilot\oa3tool.exe"} | Select-Object -First 1).Root + "Autopilot"
Write-Host -ForegroundColor Cyan "Autopilot tools found at: $AutopilotDir"
rundll32 X:\Windows\System32\PCPKsp.dll,DllInstall
& "$AutopilotDir\oa3tool.exe" /Report /ConfigFile="$AutopilotDir\OA3.cfg" /NoKeyCheck
# Convert OA3.xml to Autopilot CSV
[xml]$xml = Get-Content "$AutopilotDir\OA3.xml"
$hash = $xml.Key.HardwareHash
$serial = (Get-WmiObject Win32_BIOS).SerialNumber
"Device Serial Number,Windows Product ID,Hardware Hash" | Out-File "$AutopilotDir\..\AutopilotHash.csv" -Encoding ascii
"$serial,,$hash" | Out-File "$AutopilotDir\..\AutopilotHash.csv" -Encoding ascii -Append
Write-Host -ForegroundColor Green "Hash saved to USB - AutopilotHash.csv"
Start-Sleep -Seconds 5
Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 25H2 -OSEdition Pro -OSLanguage en-gb -OSLicense Retail -ZTI
Write-Host -ForegroundColor Green "Installation complete - remove USB and upload AutopilotHash.csv to Autopilot"
Write-Host -ForegroundColor Yellow "Device will shut down in 20 seconds..."
Start-Sleep -Seconds 20
wpeutil shutdown
