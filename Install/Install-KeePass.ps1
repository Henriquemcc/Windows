Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

if (Test-AdministratorPrivileges) {
    $url = "https://sonik.dl.sourceforge.net/project/keepass/KeePass%202.x/2.53/KeePass-2.53-Setup.exe"
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
    $url = "https://sonik.dl.sourceforge.net/project/keepass/KeePass%202.x/2.52/KeePass-2.52.zip"
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