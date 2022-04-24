function Read-Single
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    <#
    .SYNOPSIS
        Reads a single value from input.
    .DESCRIPTION
        This reads a single value from standard input, ensuring that the typed value is single.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $singleRead = $null
    while (($null -eq $singleRead) -or ($singleRead -isnot [System.Single]))
    {
        try
        {
            $inputString = Read-Host -Prompt:$Prompt


            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less or equal to zero"
            }

            $singleRead = [System.Single]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $singleRead
}