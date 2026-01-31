$Action = New-ScheduledTaskAction `
  -Execute "wscript.exe" `
  -Argument """C:\management\ensure-smb.vbs"""

$Trigger1 = New-ScheduledTaskTrigger -AtStartup
$Trigger2 = New-ScheduledTaskTrigger -AtLogOn
$Trigger3 = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5) -RepetitionDuration (New-TimeSpan -Days 3650)

$Principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive -RunLevel Highest

$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1)

Register-ScheduledTask -TaskName "Ensure smb connection with control node" -Action $Action -Trigger $Trigger1,$Trigger2,$Trigger3 -Principal $Principal -Settings $Settings

Start-ScheduledTask -TaskName "Ensure smb connection with control node"
