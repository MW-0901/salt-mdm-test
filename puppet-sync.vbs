On Error Resume Next
Set shell = CreateObject("WScript.Shell")
cmd = "powershell.exe -ExecutionPolicy Bypass -File ""C:\management\puppet-sync.ps1"""
' 0 = hidden window
' False = do not wait
shell.Run cmd, 0, False
