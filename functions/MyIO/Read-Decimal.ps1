function Read-Decimal
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    <#
    .SYNOPSIS
        Reads a decimal value from input.
    .DESCRIPTION
        This reads a decimal value from standard input, ensuring that the typed value is decimal.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $decimalRead = $null
    while (($null -eq $decimalRead) -or ($decimalRead -isnot [System.Decimal]))
    {
        try
        {
            $inputString = Read-Host -Prompt:$Prompt

            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $decimalRead = [System.Decimal]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $decimalRead
}