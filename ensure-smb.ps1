$DriveLetter = "N:"
$NetworkPath = "\\100.100.6.49\shared"
$Username = "mark"
$Password = "G0B3@RS"

if (Test-Path "$DriveLetter\") {
    exit 0
}

$cmd = "net use $DriveLetter /delete /yes & net use $DriveLetter $NetworkPath /user:$Username $Password /persistent:yes"

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = "cmd.exe"
$psi.Arguments = "/c $cmd"
$psi.CreateNoWindow = $true
$psi.UseShellExecute = $false
$psi.WindowStyle = 'Hidden'

[System.Diagnostics.Process]::Start($psi) | Out-Null

Start-Sleep -Milliseconds 500

if (Test-Path "$DriveLetter\") {
    exit 0
}

exit 1
