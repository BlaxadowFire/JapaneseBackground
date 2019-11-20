$path = $env:USERPROFILE + "\WeekdayWallPaper"



if(!(Test-Path $path)){
    Write-Output "Doesn't exist"
    New-Item -ItemType directory -Path $path
}
Write-Output $path