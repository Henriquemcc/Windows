Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-Expression.ps1"))

if (Test-Expression -Command "winget") {
    Invoke-Expression -Command "winget install XPDM27W10192Q0 --source msstore --silent --accept-source-agreements --accept-package-agreements"
}

else {

    # Download Variables
    $url = "https://download.gimp.org/gimp/v2.10/windows/gimp-2.10.32-setup-1.exe"
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation variables
    $silentInstallArgs = [System.Collections.ArrayList]::new()
    [void]$silentInstallArgs.Add("/VERYSILENT")
    [void]$silentInstallArgs.Add("/SUPRESSMSGBOXES")

    if (-not (Test-AdministratorPrivileges)) {
        [void]$silentInstallArgs.Add("/CURRENTUSER")
    }

    # Installing Gimp
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $downloadFilePath
    $process.StartInfo.Arguments = $silentInstallArgs -join " "
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}