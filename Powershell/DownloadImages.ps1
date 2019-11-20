$FileNames = @(
    "Monday.jpg",
    "Tuesday.jpg",
    "Wednesday.jpg",
    "Thursday.jpg",
    "Friday.jpg",
    "Saturday.jpg",
    "Sunday.jpg",
    "wallpaper.ps1"
)
$Uri = "https://github.com/BlaxadowFire/JapaneseBackground/blob/master/"
$OutPath = $env:USERPROFILE + "\WeekdayWallpaper\"

foreach ($fileName in $FileNames){
    $FileUri = $Uri + $fileName + "?raw=true"
    $OutPutFile = $OutPath + $fileName
    Invoke-WebRequest -Uri $FileUri -OutFile $OutputFile
}