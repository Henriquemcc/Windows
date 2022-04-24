function Read-Int64
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    <#
    .SYNOPSIS
        Reads a int64 value from input.
        .DESCRIPTION
        This reads a in64 value from standard input, ensuring that the typed value is int64.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $int64Read = $null
    while (($null -eq $int64Read) -or ($int64Read -isnot [System.Int64]))
    {
        try
        {
            $inputString = Read-Host -Prompt:$Prompt


            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $int64Read = [System.Int64]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $int64Read
}