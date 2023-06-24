Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Get-DestinationUrl.ps1"))

$baseUrl = "https://sourceforge.net/projects/keepass/files/KeePass%202.x/"
$version = "2.53.1"

if (Test-AdministratorPrivileges) {
    $url = Get-DestinationUrl -Url "$($baseUrl)$($version)/KeePass-$($version)-Setup.exe/download"
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation variables
    $silentInstallArgs = @("/VERYSILENT", "/NORESTART")

    # Installing KeePass
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $downloadFilePath
    $process.StartInfo.Arguments = $silentInstallArgs -join " "
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}

else {
    # Download Variables
    $url = Get-DestinationUrl -Url "$($baseUrl)$($version)/KeePass-$($version).zip/download"
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation Varibles
    $installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "KeePass")

    # Creating Installation Directory
    New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

    # Extracting KeePass
    Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

    # Shortcut Variables
    $executablePath = [System.IO.Path]::Combine($installationDirectoryPath, "KeePass.exe")
    $shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "KeePass.lnk")

    # Crating Shortcut
    $WScriptShell = New-Object -ComObject "WScript.Shell"
    $shortcut = $WScriptShell.CreateShortcut($ShortcutDestinationPath)
    $shortcut.TargetPath = $executablePath
    $shortcut.Save()
}