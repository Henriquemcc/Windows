function Get-DestinationUrl {
    param(
        [Parameter(Mandatory = $true)][System.String]$Url
    )

    <#
    .SYNOPSIS
        Get the destination Url from a url that redirects to another.
    .DESCRIPTION
        Obtain the destination Url from a source url which redirects to a final Url.
    .PARAMETER Url
        Source url to obtain its destination Url.
    .EXAMPLE
        Get-DestinationUrl -Url "https://example1.com"
        "https://example2.com"
    #> 

    $newUrl = $Url
    do {
        $url = $newUrl
        $webRequest = [System.Net.WebRequest]::Create($url)
        $webRequest.AllowAutoRedirect = $false

        $webResponse = $webRequest.GetResponse()
        $statusCode = $webResponse.StatusCode
        if (($statusCode -eq 'Moved' -or $statusCode -eq 'Found' -or $statusCode -eq 'SeeOther' -or $statusCode -eq 'TemporaryRedirect' -or $statusCode -eq 'PermanentRedirect') -and $webResponse.Headers['Location']) {
            $newUrl = $webResponse.Headers['Location']
        }
        else {
            $newUrl = $url
        }
        
    }
    while ($url -ne $newUrl)

    return $newUrl
}