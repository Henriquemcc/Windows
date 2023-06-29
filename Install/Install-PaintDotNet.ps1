Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

if (Test-AdministratorPrivileges) {
    
    # Download Variables
    $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "https://github.com/paintdotnet/release/releases/download/v5.0.1/paint.net.5.0.1.install.x64.zip"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        "https://github.com/paintdotnet/release/releases/download/v5.0.1/paint.net.5.0.1.install.arm64.zip"
    }
    else {
        throw "Invalid Architecture"
    }
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Extracting
    $extractionDirectoryPath = [System.IO.Path]::Combine($env:TMP, [System.IO.Path]::GetFileNameWithoutExtension($downloadFilePath))
    New-Item -Path:$extractionDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue
    Expand-Archive -Path:$downloadFilePath -DestinationPath:$extractionDirectoryPath -ErrorAction SilentlyContinue

    # Installation variables
    $installerPath = (Get-ChildItem -Path $extractionDirectoryPath -File -Recurse)[0].FullName
    $silentInstallArgs = @("/auto")

    # Installing PaintDotNet
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $installerPath
    $process.StartInfo.Arguments = $silentInstallArgs -join " "
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}

else {

    # Download Variables
    $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "https://github.com/paintdotnet/release/releases/download/v5.0.1/paint.net.5.0.1.portable.x64.zip"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        "https://github.com/paintdotnet/release/releases/download/v5.0.1/paint.net.5.0.1.portable.arm64.zip"
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
    $installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Paint.net")

    # Creating Installation Directory
    New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

    # Extracting Paint.net
    Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

    # Shotcut Variables
    $shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Paint.net.lnk")
    $executablePath = [System.IO.Path]::Combine($installationDirectoryPath, "paintdotnet.exe")

    # Creating Shortcut
    $WScriptShell = New-Object -ComObject "WScript.Shell"
    $shortcut = $WScriptShell.CreateShortcut($shortcutDestinationPath)
    $shortcut.TargetPath = $executablePath
    $shortcut.Save()

}