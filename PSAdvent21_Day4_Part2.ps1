$VerbosePreference = "silentlycontinue"

$AllPassports = (Get-Content .\Input\Day4_Passports.txt) | Out-String
$Newline = [Environment]::NewLine
$PassSplit = $AllPassports -split("$Newline$Newline")

$ValidPass = 0

$Invalidpass = 0

$RequiredFields = "byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"

Function Test-Requirement
{
    Param
    (
        [Parameter( Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0
        )]
        $RequirementName,

        [Parameter( Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=1
        )]
        $RequirementData
    )
    switch ($RequirementName) 
    {
        "byr"   {
                    if ($RequirementData -in 1920..2002) { Write-Verbose "Valid: Byr is between 1920 and 2002: $RequirementData" }
                    else { $global:Validity = $false }
                }

        "iyr"   {
                    if ($RequirementData -in 2010..2020) { Write-Verbose "Valid: iyr is between 2010 and 2020: $RequirementData" }
                    else { $global:Validity = $false }
                }
        
        "eyr"   {
                    if ($RequirementData -in 2020..2030) { Write-Verbose "Valid: eyr is between 2020 and 2030: $RequirementData" }
                    else { $global:Validity = $false }
                }

        "hcl"   {
                    if ($RequirementData -match '^(#[(a-f0-9)]{6})' -and $($RequirementData | Measure-Object -Character).Characters -eq 7) { Write-Verbose "Valid: hcl matches RegEx: $RequirementData" }
                    else { $global:Validity = $false }
                }

        "hgt"   {
                    Write-Output "TESTING HGT $RequirementData"
                    if ($RequirementData | Select-string -Pattern "in") 
                    {
                        if ($($RequirementData.split("in")[0]) -in 59..76) 
                        {
                            Write-Verbose "hgt IN is between 59 and 76: $RequirementData"
                        }
                        else 
                        { 
                            Write-Verbose "HGT IN IS INVALID: $RequirementData"
                            $global:Validity = $false
                        }
                    }
                    elseif ($RequirementData | Select-string -Pattern "cm")
                    {
                        if ($($RequirementData.split("cm"))[0] -in 150..193) 
                        {
                            Write-Verbose "hgt CM is between 150 and 193: $RequirementData"
                        }
                        else 
                        {
                            Write-Verbose "HGT IN IS INVALID: $RequirementData"
                            $global:Validity = $false
                        }
                    }
                    else 
                    {   
                        Write-Verbose "HGT IS INVALID: $RequirementData"
                        $global:Validity = $false 
                    }
                }

        "ecl"   {
                    $ValidSet = 'amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'
                    if ($ValidSet -contains $RequirementData) { Write-Verbose "Valid: ecl matches ValidSet: $RequirementData" }
                    else { $global:Validity = $false }
                }

        "pid"   {
                    if ($RequirementData -match '^([0-9]{9})'-and $($RequirementData | Measure-Object -Character).Characters -le 9) { Write-Verbose "Valid: pid matches RegEx: $RequirementData" }
                    else { $global:Validity = $false }
                }

        Default {}
    }
    return $global:Validity
}

Foreach ($Passport in $PassSplit)
{
    $global:Validity = $true

    Write-Verbose "Checking $Passport"
    foreach ($Requirement in $RequiredFields)
    {
        if (($Passport | Select-String -Pattern $Requirement) -ne $null) 
        {
            #Write-Verbose "Passport ontains $Requirement"

            $Delimiters = "$($Passport | Select-String -Pattern $Requirement)", " "
            $RequireSplit = $Passport -Split {$Delimiters -contains $_} | Out-String

            $HashReq = ConvertFrom-StringData -StringData $RequireSplit -Delimiter ":"

            $Requirement = $($Requirement -split (":"))[0]
            
            $global:Validity = Test-Requirement -RequirementName $Requirement -RequirementData $HashReq.$Requirement

            if ($global:Validity -eq $false) 
            {
                $Invalidpass ++
                break
            }

            #SPLIT STRING ON REQUIREMENT 
            #SPLIT ON FORMAT OF REQUIREMENT
            #CHECK REQUIREMENT STATEMENT
        }
        else
        {
            Write-Verbose "$Requirement not found! Passport is invalid"
            $Invalidpass ++
            $global:Validity = $false
            break
        }
    }
    #when all requirements are checked. Check if Validity is still true
    if ($global:Validity -eq $true) 
    {
        Write-Verbose "Passport is VALID"
        $ValidPass ++
    }
}
Write-Output "All passports checked"
Write-Output "Total passports $($PassSplit.Count)"
Write-Output ""
Write-Output "VALID: $ValidPass"
Write-Output "invalid: $Invalidpass"