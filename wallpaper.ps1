$BasePath = $env:USERPROFILE + "\WeekdayWallpaper\"
 
$Day = Get-Date -Format dddd




$FileName = $Day + ".bmp"
$FilePath = $BasePath + $FileName

Function Set-WallPaper($imagePath)
 {
    Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $imagePath
    rundll32.exe user32.dll, UpdatePerUserSystemParameters
    RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
 }
 Function Set-LockScreen($imagePath)
 {
    REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP /f
    REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP /v LockScreenImagePath /t REG_SZ /d $imagePath /f
    REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP /v LockScreenImageUrl /t REG_SZ /d $imagePath /f
    REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP /v LockScreenImageStatus /t REG_DWORD /d 1 /f
}

 


 Write-Output "$FilePath"
 Set-WallPaper -imagePath "$FilePath"
 Set-LockScreen -imagePath "$FilePath"

 cmd /c pause | out-null