$input = whoami /user /fo list
$regexperssion = "SID:\s+([\s\S_]+)"

#$output = $input -match "SID:\s+([\s\S_]+)"
$output = [regex]::Match($input,$regexperssion).captures.groups[1].value

Write-Output $output