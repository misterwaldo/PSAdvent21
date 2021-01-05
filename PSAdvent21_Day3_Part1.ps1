$SlopeInput = Get-Content .\Day3_Forest.txt

$XPos = 0
$Tree = 0
$Clear = 0

Foreach ($Line in $SlopeInput)
{
    if ($Line[$XPos] -eq "#")
    {
        $Line[$XPos]
        Write-Verbose "HIT A TREE!"
        $Tree++
    }
    else 
    {
        $Line[$Xpos]
        Write-Verbose "all is clear"
        $Clear++
    }

    $XPos += 3
    if ($XPos -ge 31)
    {
        $Xpos -= 31
        
    }
    Write-Verbose "New Xpos = $Xpos"
}
Write-Output  "Done"
Write-Output "Trees hit: $Tree"
Write-Output "Clear: $Clear"