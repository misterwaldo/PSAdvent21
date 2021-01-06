$SlopeInput = Get-Content .\Day3_Forest.txt

$Skipline = $false

$Multiplier = 1

$MoveTable = @()
$MoveTable += [pscustomobject]@{
    XMove = 1
    YMove = 1
    }
$MoveTable += [pscustomobject]@{
    XMove = 3
    YMove = 1
}
$MoveTable += [pscustomobject]@{
    XMove = 5
    YMove = 1
}
$MoveTable += [pscustomobject]@{
    XMove = 7
    YMove = 1
}
$MoveTable += [pscustomobject]@{
    XMove = 1
    YMove = 2
}

foreach ($Move in $MoveTable) 
{
    $XPos = 0
    $Tree = 0
    $Clear = 0

        Foreach ($Line in $SlopeInput)
        {
            if ($Skipline -eq $false)
            {
                if ($Line[$XPos] -eq "#")
                {
                    Write-Verbose "$($Line[$XPos])"
                    Write-Verbose "HIT A TREE!"
                    $Tree++
                }
                else 
                {
                    Write-Verbose "$($Line[$Xpos])"
                    Write-Verbose "all is clear"
                    $Clear++
                }
            
                $XPos += $Move.XMove
                if ($XPos -ge 31)
                {
                    $Xpos -= 31
                
                }
                Write-Verbose "New Xpos = $Xpos"

                if ($Move.YMove -ge 2 -and $Skipline -eq $false)
                {
                    Write-Verbose "Y position move is more than 1 skipping next line"
                    $Skipline = $true
                }
            }
            else 
            {
                $Skipline = $false
            }
    }


    $Multiplier *= $Tree

    Write-Output  "Done with $Move"
    Write-Output "Trees hit: $Tree"
    Write-Output "Clear: $Clear"
    Write-Output "Multiplier count: $Multiplier"
}

Write-Output "Done"
Write-Output "Total multiplier = $Multiplier"