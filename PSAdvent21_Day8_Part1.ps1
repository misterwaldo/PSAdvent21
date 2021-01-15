$VerbosePreference = "continue"

$InstructionInput = Get-Content .\Input\Day8_Instructions.txt
$InstructionSet = @()

$Global:Accumulator = @()
$Global:InstructionPosition = 0
$Global:ProcessedInstructions = @()

foreach ($line in $InstructionInput)
{
    $InstructionSet += [PSCustomObject]@{
        Instruction = ($Line.Split(" "))[0]
        Value       = @($Line.Split(" "))[1]
    }
}
function Complete-Instruction
{
    param 
    (
        $Instruction
    )
    switch ($instruction.Instruction) 
    {
        "acc"   {
                    Write-Verbose "ACC: $($Instruction.Value)"
                    $Global:Accumulator = invoke-expression "$Global:Accumulator $($Instruction.value)"
                    $Global:InstructionPosition += 1
                }
        "jmp"   {
                    Write-Verbose "JMP: $($Instruction.Value)"
                    $Global:InstructionPosition = invoke-expression "$Global:InstructionPosition $($Instruction.value)"
                }

        "nop"   {
                    Write-Verbose "NOP"
                    $Global:InstructionPosition += 1
                }

        Default {}
    }
    Write-Verbose "Returning new position: $Global:InstructionPosition"
    return $Global:InstructionPosition
    
}
$functionoutput = complete-instruction -instruction $($InstructionSet[$Global:InstructionPosition])

do 
{   
    $FunctionInput = $functionoutput
    $Global:ProcessedInstructions += $functionoutput

    $Functionoutput = complete-instruction -instruction $($InstructionSet[$FunctionInput])
}
while ($Global:ProcessedInstructions -notcontains $Global:InstructionPosition)

$Global:Accumulator | Measure-Object -Maximum

Write-Output "Last value $($Global:Accumulator[-1])"