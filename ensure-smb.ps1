$DriveLetter = "Z:"
$NetworkPath = "\\100.100.6.49\shared"
$Username = "mark"
$Password = "G0B3@RS"

try {
    if (Test-Path "$DriveLetter\") {
        exit 0
    }
} catch {
    net use $DriveLetter /delete 2>$null
}

try {
    net use $DriveLetter $NetworkPath /user:$Username $Password /persistent:yes 2>&1 | Out-Null
} catch {
}
