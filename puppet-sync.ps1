$PuppetPath = "N:\manifests"
$ControlNodeUrl = "http://100.100.6.49:8000/alive"
$Hostname = $env:COMPUTERNAME

if (-not (Test-Path "N:\")) {
    Write-Error "N: drive not mounted"
    exit 1
}

$PuppetResult = $null
try {
    $PuppetOutput = & puppet apply "$PuppetPath" 2>&1
    $PuppetExitCode = $LASTEXITCODE
    $PuppetResult = if ($PuppetExitCode -eq 0) { "success" } else { "failed" }
} catch {
    $PuppetExitCode = 1
    $PuppetResult = "error"
}

$Timestamp = (Get-Date).ToUniversalTime().ToString("o")
$Body = @{
    hostname = $Hostname
    status = $PuppetResult
    exit_code = $PuppetExitCode
    timestamp = $Timestamp
} | ConvertTo-Json

try {
    Invoke-RestMethod -Uri $ControlNodeUrl -Method Post -Body $Body -ContentType "application/json" -TimeoutSec 10
} catch {
    Write-Error "Failed to report status: $_"
}

exit $PuppetExitCode
