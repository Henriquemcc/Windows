function Read-Char
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    <#
    .SYNOPSIS
        Reads a char value from input.
    .DESCRIPTION
        This reads a char value from standard input, ensuring that the typed value is char.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $charRead = $null
    while (($null -eq $charRead) -or ($charRead -isnot [System.Char]))
    {
        try
        {
            $inputString = Read-Host -Prompt:$Prompt

            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $charRead = $inputString[0]
        }

        catch
        {
            Write-Error $_
        }
    }

    return $charRead
}