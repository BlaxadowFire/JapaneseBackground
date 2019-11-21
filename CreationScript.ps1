#SECTION VARIABLES
    $FileNames = @(
    "Monday.jpg",
    "Tuesday.jpg",
    "Wednesday.jpg",
    "Thursday.jpg",
    "Friday.jpg",
    "Saturday.jpg",
    "Sunday.jpg",
    "wallpaper.ps1")
    $Path = $env:USERPROFILE + "\WeekdayWallpaper\"
    $ScriptLocation = $path + $FileNames[7]
    $Uri = "https://github.com/BlaxadowFire/JapaneseBackground/blob/master/"
    $Arguments = '-window hidden -NonInteractive -NoLogo -File "' +  $ScriptLocation + '"'
#SECTION VARIABLES END

#SECTION FUNCTIONS

    #Downloads give files from base URI to Path
    Function DownloadFiles($fileNames)
    {
        foreach ($fileName in $fileNames)
        {
            If (!([System.IO.File]::Exists($Path + $fileName)))
            {
                DownloadFile -fileName $fileName
            }
        }
    }

    #Downloads given file from base URI to Path
    Function DownloadFile($fileName)
    {
        $fileUri = $Uri + $fileName + "?raw=true"
        $outPutFile = $Path + $fileName
        Invoke-WebRequest -Uri $fileUri -OutFile $outputFile
    }

    Function DirCheck($fileNames)
    {
        #Checks if Directory exists
        if(!(Test-Path $Path))
        {
            #Create Directory
            New-Item -ItemType directory -Path $Path
        }

        #Download all files if not existing
        DownloadFiles -fileNames $fileNames
    }

    Function Get-SID()
    {
        #Get Current user SID
        $input = whoami /user /fo list
        $regexperssion = "SID:\s+([\s\S_]+)"
        return [regex]::Match($input,$regexperssion).captures.groups[1].value
    }

    Function CreateTask()
    {
        $sid = Get-SID

        #Create Task
        $TaskName = 'Change Wallpaper'
        $Action = New-ScheduledTaskAction -Execute 'powershell.exe'-Argument $Arguments
        $Trigger = New-ScheduledTaskTrigger -AtLogOn
        $Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
        $Principal = New-ScheduledTaskPrincipal -LogonType Interactive -UserId $sid -Id 'Author' -RunLevel Highest
        $Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings -Principal $Principal
        Register-ScheduledTask -TaskName $TaskName -InputObject $Task -Force
    }

#SECTION FUNCTIONS END

#The executed code
Dircheck -fileNames $FileNames
CreateTask