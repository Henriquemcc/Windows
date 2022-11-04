function Get-FileNameFromUrl{
    param (
        [Parameter(Mandatory=$true)][System.String]$Url
    )

    $webRequest = [System.Net.HttpWebRequest]::Create($Url)
    $webRequest.Method = "HEAD"
    $response = $webRequest.GetResponse()
    $fileName = [System.IO.Path]::GetFileName($response.ResponseUri)
    $response.Close()
    return $fileName
}