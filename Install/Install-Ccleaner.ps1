Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -Parent), "functions", "Util", "Get-FileNameFromUrl.ps1"))

if (Test-AdministratorPrivileges) {

    # Download Variables
    $url = "https://bits.avcdn.net/productfamily_CCLEANER/insttype_FREE/platform_WIN_PIR/installertype_ONLINE/build_RELEASE"
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation variables
    $silentInstallArgs = @("/S")

    # Installing Ccleaner
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $downloadFilePath
    $process.StartInfo.Arguments = $silentInstallArgs -join " "
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}

else {

    # Download Variables
    $url = "https://download.ccleaner.com/portable/ccsetup608.zip"
    $downloadFileName = Get-FileNameFromUrl -Url:$url
    $downloadFilePath = [System.IO.Path]::Combine($env:TMP, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation Varibles
    $installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Ccleaner")

    # Creating Installation Directory
    New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

    # Extracting Audacity
    Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

    # Shotcut Variables
    $shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Ccleaner.lnk")
    $baseName = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "CCleaner64"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        "CCleaner"
    }
    $executablePath = (Get-ChildItem -Path:$installationDirectoryPath -File | Where-Object { $_.BaseName.Contains($baseName) })[0].FullName

    # Creating Shortcut
    $WScriptShell = New-Object -ComObject "WScript.Shell"
    $shortcut = $WScriptShell.CreateShortcut($shortcutDestinationPath)
    $shortcut.TargetPath = $executablePath
    $shortcut.Save()
}