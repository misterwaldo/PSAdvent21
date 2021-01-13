$VerbosePreference = "continue"
$AllBags = Get-Content .\Input\Day7_Bags.txt
$Bagholders = @()
$Global:AllBagHolders = @()

function Find-Bagholder 
{
    param 
    (
        [Parameter( Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0
        )]
        $BagInput
    )

    $Bagholders = @()

    Write-Verbose "Starting search for $baginput"
    foreach ($Bag in $BagInput) 
    {
        Write-Verbose "Checking $bag"

        foreach ($Rule in $AllBags) 
        {
            $Rule = $Rule -split(" bags contain")

            #Write-Verbose "Checking $rule"
            
            if ($Rule[1] -like "*$($Bag)*")
            {
                Write-Verbose "$($Rule[0]) can contain a $Bag bag directly"
    
                $Bagholders += $($Rule[0]).TrimEnd()
            }
        }
    }
    $Global:AllBagHolders += $Bagholders
    return $Bagholders
}

$functionoutput = Find-Bagholder -BagInput "shiny gold"

do 
{   
    $FunctionInput = $functionoutput
    $Functionoutput = Find-Bagholder -BagInput $FunctionInput
}
while ($Functionoutput -ne $null)

($Global:AllBagHolders | Select-Object -Unique).count
