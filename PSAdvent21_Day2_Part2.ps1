$PasswordInput = Get-Content .\PasswordInput.txt

$MatchingPasswords = 0

$NotMatchingPasswords = 0

$Inconclusive = 0

foreach ($Password in $PasswordInput)
{
    $Delimiters = "-"," ",":"

    $Split = $Password -Split {$Delimiters -contains $_}

    $FirstPosition = $Split[0] -as [int]
    $FirstPosition--

    $SecondPosition = $Split[1] -as [int]
    $SecondPosition--

    $Symbol = $Split[2]

    $UserPass = $Split[4]
    
    if($Userpass[$FirstPosition] -eq $Symbol -and $UserPass[$SecondPosition] -eq $symbol)
    {
        Write-Output "Userpass is invalid! Both $FirstPosition and $SecondPosition are $symbol"
        $NotMatchingPasswords ++
    }
    elseif ($Userpass[$FirstPosition] -ne $Symbol -and $UserPass[$SecondPosition] -ne $symbol)
    {
        Write-Output "Userpass is invalid! NEITHER $FirstPosition and $SecondPosition are $symbol"
        $NotMatchingPasswords ++
    }
    elseif ($Userpass[$FirstPosition] -eq $Symbol -or $UserPass[$SecondPosition] -eq $symbol)
    {
        Write-Output "Userpass is VALID, one of the positions matches the symbol"
        $MatchingPasswords ++
    }
    else 
    {
        Write-Output "INCONCLUSIVE"
        $Inconclusive ++
    }
}

Write-Output "Done"
Write-Output "Found $MatchingPasswords matching passwords"
Write-Output "$NotMatchingPasswords did not match"
Write-Output "$inconclusive passwords are inconclusive"
