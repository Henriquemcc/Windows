function Read-Byte
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    <#
    .SYNOPSIS
        Reads a byte value from input.
    .DESCRIPTION
        This reads a byte value from standard input, ensuring that the typed value is byte.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $byteRead = $null
    while (($null -eq $byteRead) -or ($byteRead -isnot [System.Byte]))
    {
        try
        {
            $inputString = Read-Host -Prompt:$Prompt

            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $byteRead = [System.Byte]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $byteRead
}