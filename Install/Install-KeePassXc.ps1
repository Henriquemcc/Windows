Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-Expression.ps1"))

if (Test-AdministratorPrivileges) {

    if (($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") -and (Test-Expression -Command "winget")) {
        try {
            Invoke-Expression -Command "winget install XP8K2L36VP0QMB --source msstore --silent --accept-source-agreements --accept-package-agreements" -ErrorAction Stop
        }
        catch {
            Invoke-Expression -Command "winget install -e --id KeePassXCTeam.KeePassXC --silent --accept-source-agreements --accept-package-agreements"
        }
    }
    elseif (($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") -and (Test-Expression -Command "choco")) {
        Invoke-Expression -Command "choco install keepassxc --yes"
    }

    else {

        # Download Variables
        $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
            "https://github.com/keepassxreboot/keepassxc/releases/download//2.7.4/KeePassXC-2.7.4-Win64.msi"
        }
        elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
            "https://github.com/keepassxreboot/keepassxc/releases/download/2.6.6/KeePassXC-2.6.6-Win32.msi"
        }
        else {
            throw "Invalid Architecture"
        }
        $downloadFileName = [System.IO.Path]::GetFileName($url)
        $downloadDirectoryPath = $env:TMP
        $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

        # Downloading
        Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

        # Installation variables
        $silentInstallArgs = @("/i", "`"$downloadFilePath`"", "/qn", "/norestart")

        # Installing KeePassXc
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = [System.IO.Path]::Combine($env:windir, "System32", "msiexec.exe")
        $process.StartInfo.Arguments = $silentInstallArgs -join " "
        $process.StartInfo.UseShellExecute = $true
        $process.Start()
        $process.WaitForExit()
    }
}

else {
    # Download Variables
    $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "https://github.com/keepassxreboot/keepassxc/releases/download/2.7.4/KeePassXC-2.7.4-Win64.zip"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        "https://github.com/keepassxreboot/keepassxc/releases/download/2.6.6/KeePassXC-2.6.6-Win32-portable.zip"
    }
    else {
        throw "Invalid Architecture"
    }
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation Varibles
    $installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "KeePassXC")

    # Creating Installation Directory
    New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

    # Extracting KeePassXc
    Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

    # Shortcut Variables
    $executablePath = [System.IO.Path]::Combine((Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object { $_.BaseName.Contains("KeePassXC") })[0].FullName, "KeePassXC.exe")
    $shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "KeePassXC.lnk")

    # Crating Shortcut
    $WScriptShell = New-Object -ComObject "WScript.Shell"
    $shortcut = $WScriptShell.CreateShortcut($ShortcutDestinationPath)
    $shortcut.TargetPath = $executablePath
    $shortcut.Save()
}