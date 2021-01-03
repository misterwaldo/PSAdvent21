$PasswordInput = Get-Content .\PasswordInput.txt

$MatchingPasswords = 0

$NotMatchingPasswords = 0

foreach ($Password in $PasswordInput)
{
    $Delimiters = "-"," ",":"

    $Split = $Password -Split {$Delimiters -contains $_}

    $MinNumber = $Split[0]

    $MaxNumber = $Split[1]

    $Symbol = $Split[2]

    $UserPass = $Split[4]

    $SymbolCount = (Select-String -InputObject $UserPass -Pattern $Symbol -AllMatches).Matches.Count
    if ($SymbolCount -In $MinNumber..$MaxNumber) 
    {
        Write-Output "Userpass matches policy! $($UserPass) contains $SymbolCount instances of the symbol $Symbol which is between $MinNumber and $MaxNumber"
        
        $MatchingPasswords ++
    }
    else
    {
        $NotMatchingPasswords ++
    }
}

Write-Output "Done"
Write-Output "Found $MatchingPasswords matching passwords"
Write-Output "$NotMatchingPasswords did not match"
