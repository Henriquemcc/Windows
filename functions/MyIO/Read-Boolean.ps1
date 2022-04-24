function Read-Boolean
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    <#
    .SYNOPSIS
        Reads a boolean value from input.
    .DESCRIPTION
        This reads a boolean value from standard input, ensuring that the typed value is boolean.
    .PARAMETER Prompt
        Message to be prompted before reading input.
    #>

    $booleanRead = $null
    while (($null -eq $booleanRead) -or ($booleanRead -isnot [System.Boolean]))
    {
        try
        {
            $inputString = Read-Host -Prompt:$Prompt


            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $booleanRead = [System.Boolean]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $booleanRead
}