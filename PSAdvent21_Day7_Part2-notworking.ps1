$VerbosePreference = "continue"
$AllBags = Get-Content .\Input\Day7_Bags.txt
$BagContents = @()
$Global:AllBagHolders = @()

function Find-SubBags
{
    param 
    (
        [Parameter( Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0
        )]
        $BagInput
    )

    $BagContents = @()

    Write-Verbose "Starting search for $baginput"

    foreach ($SearchBag in $BagInput) 
    {
        $FoundBag = ($AllBags | Select-String -Pattern ("$($SearchBag.trimend()) bags contain ")).ToString()
        write-host $FoundBag

        $Numbers = (($FoundBag -replace "[^0-9,]", '') -split ",")

        if ($Numbers)
        {
            Write-Verbose "numbers $numbers found"

            foreach ($Nr in $Numbers) 
            {
                $Split = $FoundBag.Split("$Nr ")[1]
                $Split  = $Split.split("bag")[0]

                Write-Verbose "Found $Nr $Split"

                $BagContents += [PSCustomObject]@{
                    Bagnumber = (($Numbers | Measure-Object -Sum).Sum) -as [int]
                    Bag = $Split
                    Amount = $Nr
                }
            }
        }
        else 
        {
        Write-Verbose "no new bags found"
        }
    }
    $Global:AllBagHolders += $BagContents

    return $BagContents
}

$functionoutput = Find-SubBags -BagInput "shiny gold"

do 
{   
    $FunctionInput = $functionoutput.bag
    $Functionoutput = Find-SubBags -BagInput $FunctionInput
}
while ($Functionoutput -ne $null)

$total = 1

foreach ($item in $Global:AllBagHolders) 
{
    Write-Host "MULTIPLYING BY $($item.Bagnumber)"

    $total *= $item.Bagnumber
}

$total