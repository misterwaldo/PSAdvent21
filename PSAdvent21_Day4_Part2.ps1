$VerbosePreference = "continue"

$AllPassports = (Get-Content .\Input\Day4_Passports.txt) | Out-String
$Newline = [Environment]::NewLine
$PassSplit = $AllPassports -split("$Newline$Newline")

$ValidPass = 0

$Invalidpass = 0

$RequiredFields = "byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"

Foreach ($Passport in $PassSplit)
{
    $Validity = $true

    Write-Verbose "Checking $Passport"
    foreach ($Requirement in $RequiredFields)
    {
        if (($Passport | Select-String -Pattern $Requirement) -ne $null) 
        {
            Write-Verbose "Passport ontains $Requirement"
            #SPLIT STRING ON REQUIREMENT 
            #SPLIT ON FORMAT OF REQUIREMENT
            #CHECK REQUIREMENT STATEMENT
        }
        else
        {
            Write-Verbose "$Requirement not found! Passport is invalid"
            $Invalidpass ++
            $Validity = $false
            break
        }
    }

    if ($validity -eq $true) 
    {
        $ValidPass ++
    }
}
Write-Output "All passports checked"
Write-Output "Total passports $($PassSplit.Count)"
Write-Output ""
Write-Output "VALID: $ValidPass"
Write-Output "invalid: $Invalidpass"