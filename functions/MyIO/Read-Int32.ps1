function Read-Int32
{
    param(
        [Parameter(Mandatory = $false)] $Prompt = $null
    )

    <#
    .SYNOPSIS
        Reads a int32 value from input.
    .DESCRIPTION
        This reads a int32 value from standard input, ensuring that the typed value is int32.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $int32Read = $null
    while (($null -eq $int32Read) -or ($int32Read -isnot [System.Int32]))
    {
        try
        {

            $inputString = Read-Host -Prompt:$Prompt

            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $int32Read = [System.Int32]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $int32Read

}