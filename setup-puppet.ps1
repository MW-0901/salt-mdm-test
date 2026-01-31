$Action = New-ScheduledTaskAction `
  -Execute "wscript.exe" `
  -Argument """C:\management\puppet-sync.vbs"""

$StartTime = (Get-Date -Hour 0 -Minute 0 -Second 0).AddDays(0)
$Trigger = New-ScheduledTaskTrigger `
  -Once `
  -At $StartTime `
  -RepetitionInterval (New-TimeSpan -Minutes 30)

$Principal = New-ScheduledTaskPrincipal `
  -UserId "$env:USERDOMAIN\$env:USERNAME" `
  -LogonType Interactive `
  -RunLevel Highest

$Settings = New-ScheduledTaskSettingsSet `
  -AllowStartIfOnBatteries `
  -DontStopIfGoingOnBatteries `
  -StartWhenAvailable `
  -RestartCount 3 `
  -RestartInterval (New-TimeSpan -Minutes 1)

Unregister-ScheduledTask -TaskName "Puppet Sync" -Confirm:$false -ErrorAction SilentlyContinue

Register-ScheduledTask `
  -TaskName "Puppet Sync" `
  -Action $Action `
  -Trigger $Trigger `
  -Principal $Principal `
  -Settings $Settings

Write-Host "Scheduled task 'Puppet Sync' created successfully"
Write-Host "Task will run at :00 and :30 of every hour"

Start-ScheduledTask -TaskName "Puppet Sync"
Write-Host "Task started for immediate test run"
