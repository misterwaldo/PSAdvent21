$VerbosePreference = "silentlycontinue"
$AllBoarding = Get-Content .\Input\Day5_Boardingpass.txt
$Global:AllSeatIDs = @()

Function Get-SeatID
{
    Param
    (
        [Parameter( Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0
        )]
        $SeatInput,

        [Parameter( Mandatory=$false,
        ValueFromPipelineByPropertyName=$true,
        Position=1
        )]
        $LowRow = 0,

        [Parameter( Mandatory=$false,
        ValueFromPipelineByPropertyName=$true,
        Position=2
        )]
        $HighRow = 127,

        [Parameter( Mandatory=$false,
        ValueFromPipelineByPropertyName=$true,
        Position=3
        )]
        $LowCol = 0,

        [Parameter( Mandatory=$false,
        ValueFromPipelineByPropertyName=$true,
        Position=4
        )]
        $HighCol = 7
    )

    foreach ($char in [char[]]$SeatInput) 
    { 
        Write-Verbose "Current input: $char" 
        if ($char -eq "F") 
        {
            $HighRow = ([Math]::Floor(($LowRow + $HighRow) / 2))

            Write-Verbose "New LowRow is $LowRow"
            Write-Verbose "New HighRow is $HighRow"
        }
        if ($char -eq "B")
        {
            $LowRow = ([Math]::Ceiling(($HighRow + $LowRow) / 2))

            Write-Verbose "New LowRow is $LowRow"
            Write-Verbose "New HighRow is $HighRow"
        }`

        if ($char -eq "L") 
        {
            $HighCol = ([Math]::Floor(($LowCol + $HighCol) / 2))

            Write-Verbose "New LowCol is $LowCol"
            Write-Verbose "New HighCol is $HighCol"
        }

        if ($char -eq "R")
        {
            $LowCol = ([Math]::Ceiling(($HighCol + $LowCol) / 2))

            Write-Verbose "New LowCol is $LowCol"
            Write-Verbose "New HighCol is $HighCol"
        }
    }
    if ($HighRow -eq $LowRow)
    {
        Write-Verbose "Row found! $HighRow"
        $DefRow = $HighRow
    }
    else 
    {
        Write-Output "Error: UNABLE to find ROW!"
    }

    if ($HighCol -eq $LowCol)
    {
        Write-Verbose "COLUMN found! $HighCol"
        $DefCol = $HighCol
    }
    else 
    {
        Write-Output "Error: UNABLE to find COLUMN!"
    }

    $Global:AllSeatIDs += $DefRow * 8 + $DefCol

}

foreach ($Boardpass in $AllBoarding)
{
    Get-SeatID -SeatInput $Boardpass

}

$Global:AllSeatIDs | Measure-Object -Maximum