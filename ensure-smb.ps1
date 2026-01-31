$DriveLetter = "Z:"
$DriveName = "Z"
$NetworkPath = "\\100.100.6.49\shared"
$Username = "mark"
$Password = "G0B3@RS"

Remove-PSDrive -Name $DriveName -ErrorAction SilentlyContinue

net use $DriveLetter /delete /yes 2>$null

$result = net use $DriveLetter $NetworkPath /user:$Username $Password /persistent:yes 2>&1

if (Test-Path "$DriveLetter\") {
    exit 0
} else {
    exit 1
}
