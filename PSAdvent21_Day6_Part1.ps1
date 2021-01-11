$VerbosePreference = "continue"

$TotalCount = 0

$AllForms = (Get-Content .\Input\Day6_CustomsDec.txt) | Out-String
$Newline = [Environment]::NewLine
$FormsSplit = $AllForms -split("$Newline$Newline")

$Alphabet = (97..122 | ForEach-Object {[char]$_})

foreach ($Form in $FormsSplit)
{
    Write-Verbose "Checking $Form"
    $QuestionCount = 0

    foreach ($Letter in $Alphabet)
    {
        if ([char[]]$Form -contains $Letter)
        {
            Write-Verbose "Form Contains $Letter"
            $QuestionCount ++
        }
    }

    $TotalCount += $QuestionCount
}

Write-Output "The sum off all questions = $TotalCount"