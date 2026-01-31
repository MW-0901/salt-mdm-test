$DriveLetter = "N:"
$DriveName = "N"
$NetworkPath = "\\100.100.6.49\shared"
$Username = "mark"
$Password = "G0B3@RS"

Write-Host "Initiating smb connection..."

Write-Host "Removing PSDrive Z if it exists..."
Remove-PSDrive -Name $DriveName -Force -ErrorAction SilentlyContinue

Write-Host "Deleting existing network mapping..."
net use $DriveLetter /delete /yes 2>&1

Start-Sleep -Milliseconds 500

Write-Host "Mapping network drive $DriveLetter to $NetworkPath..."
$result = net use $DriveLetter $NetworkPath /user:$Username $Password /persistent:yes 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "Drive mapped successfully" -ForegroundColor Green
} else {
    Write-Host "Failed to map drive. Exit code: $LASTEXITCODE" -ForegroundColor Red
    Write-Host "Output: $result" -ForegroundColor Red
}

if (Test-Path "$DriveLetter\") {
    Write-Host "Drive is accessible" -ForegroundColor Green
    exit 0
} else {
    Write-Host "FAIL: Drive is not accessible" -ForegroundColor Red
    exit 1
}
