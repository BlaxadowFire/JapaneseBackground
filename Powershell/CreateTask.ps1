#Get Current user SID
$input = whoami /user /fo list
$regexperssion = "SID:\s+([\s\S_]+)"
$sid = [regex]::Match($input,$regexperssion).captures.groups[1].value

#Create Task
$TaskName = 'Change Wallpaper1'
$Action = New-ScheduledTaskAction -Execute 'powershell.exe'-Argument '-window hidden -NonInteractive -NoLogo -File "C:\Users\NKOOLS98\OneDrive - Conclusion\Bureaublad\wallpaper.ps1"'
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$Principal = New-ScheduledTaskPrincipal -LogonType Interactive -UserId $sid -Id 'Author' -RunLevel Highest
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings -Principal $Principal
Register-ScheduledTask -TaskName $TaskName -InputObject $Task -Force