function Read-Int16
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    <#
    .SYNOPSIS
        Reads a int16 value from input.
    .DESCRIPTION
        This reads a int16 value from standard input, ensuring that the typed value is int16.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $int16Read = $null
    while (($null -eq $int16Read) -or ($int16Read -isnot [System.Int16]))
    {
        try
        {
            $inputString = Read-Host -Prompt:$Prompt

            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $int16Read = [System.Int16]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $int16Read
}