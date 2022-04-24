function Read-Double
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    <#
    .SYNOPSIS
        Reads a double value from input.
    .DESCRIPTION
        This reads a double value from standard input, ensuring that the typed value is double.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $doubleRead = $null
    while (($null -eq $doubleRead) -or ($doubleRead -isnot [System.Double]))
    {
        try
        {

            $inputString = Read-Host -Prompt:$Prompt

            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $doubleRead = [System.Double]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $doubleRead
}