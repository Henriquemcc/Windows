class MirrorObject:System.IComparable {

    <#
    .SYNOPSIS
        Stores mirror url and its latency.
    .DESCRIPTION
        A class which stores url and latency of a mirror server.
    #>
    

    [System.String]$Url
    [System.Double]$Latency

    MirrorObject($Url, $Latency)
    {
        $this.Url = $Url
        $this.Latency = $Latency
    }

    [System.Int32]CompareTo($obj)
    {
        return $this.Latency.CompareTo($obj.Latency)
    }
}

function Get-FastestMirror
{

    <#
    .SYNOPSIS
        From a list of servers, retrieves the fastest.
    .PARAMETER MirrorList
        List of mirror servers to get the fastest.
    .DESCRIPTION
        Test each server from the list and returns the fastest mirror according to its latency.
    .EXAMPLE
        Get-FastestMirror -MirrorList @("https://google.com", "https://yahoo.com")
        Check which server has the lowest latency Google or Yahoo.
    #>
    

    param(
        # List of mirror servers to test
        [Parameter(Mandatory = $true)][System.Object[]]$MirrorList
    )

    # Empty list to store latency test data
    $testedMirrorList = [System.Collections.ArrayList]::new()

    # Testing each mirror
    foreach($mirror in $MirrorList)
    {
        # Getting hostname
        $hostName = $null
        try {
            $hostName = [System.Uri]::new($mirror).Host
        }
        catch
        {
            $hostName = $mirror
        }
        

        # Testing conection
        try{

            # Testing conection
            $test = Test-Connection -ComputerName:$hostName -ErrorAction Stop

            # Calculating the average latency
            $latency = 0
            foreach($t in $test)
            {
                $latency += $t.ResponseTime
            }
            $latency /= $test.Length

            # Creating mirror object and adding it to array list
            [void]$testedMirrorList.Add([MirrorObject]::new($mirror, $latency))
        }
        catch
        {
            Write-Host -Object $_
        }

    }

    # Sorting list
    $testedMirrorList.Sort()

    return $testedMirrorList[0].Url
}