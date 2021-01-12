$VerbosePreference = "continue"

$TotalCount = 0
$QuestionCount = 0
$AllForms = ((Get-Content .\Input\Day6_CustomsDec.txt) | Out-String).TrimEnd()
$Newline = [Environment]::NewLine
$AllGroups = $AllForms -split("$Newline$Newline")

foreach ($CurrentGroup in $AllGroups)
{
    $GroupCount = ($Currentgroup -split "$Newline").Length
    $CurrentGroup = ($CurrentGroup -replace "$NewLine", "").ToCharArray() | Group-Object | Where-Object Count -eq $GroupCount

    Write-Verbose "Current group number of questions: $($Currentgroup.length)"
    $TotalCount += $CurrentGroup.Length
}

Write-Output "The sum off all questions = $TotalCount"