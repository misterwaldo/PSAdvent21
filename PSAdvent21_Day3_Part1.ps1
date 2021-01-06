$SlopeInput = Get-Content .\Day3_Forest.txt

$XPos = 0
$Tree = 0
$Clear = 0

$XMoves = 1,3,5,7,1
YMoves =

$HashMove = 

foreach ($Xmove in $XMoves) 
{
    
    Foreach ($Line in $SlopeInput)
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

        $XPos += $XMove
        if ($XPos -ge 31)
        {
            $Xpos -= 31

        }
        Write-Verbose "New Xpos = $Xpos"
    }

    Write-Output  "Done with $XMove"
    Write-Output "Trees hit: $Tree"
    Write-Output "Clear: $Clear"
}

Write-Output  "Done"
Write-Output "Trees hit: $Tree"
Write-Output "Clear: $Clear"