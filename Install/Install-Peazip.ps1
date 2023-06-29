Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-Expression.ps1"))

if (Test-AdministratorPrivileges) {

    if (Test-Expression -Command "winget") {
        Invoke-Expression -Command "winget install -e peazip --silent --accept-source-agreements --accept-package-agreements"
    }

    else {
    
        # Download Variables
        $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
            "https://github.com/peazip/PeaZip/releases/download/9.0.0/peazip-9.0.0.WIN64.exe"
        }
        elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
            "https://github.com/peazip/PeaZip/releases/download/9.0.0/peazip-9.0.0.WINDOWS.exe"
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
        $silentInstallArgs = @("/VERYSILENT", "/NORESTART")

        # Installing Peazip
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = $downloadFilePath
        $process.StartInfo.Arguments = $silentInstallArgs -join " "
        $process.StartInfo.UseShellExecute = $true
        $process.Start()
        $process.WaitForExit()
    }
}

else {
    
    # Download Variables
    $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "https://github.com/peazip/PeaZip/releases/download/9.0.0/peazip_portable-9.0.0.WIN64.zip"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        "https://github.com/peazip/PeaZip/releases/download/9.0.0/peazip_portable-9.0.0.WINDOWS.zip"
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
    $installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Peazip")
    
    # Creating Installation Directory
    New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue
    
    # Extracting Peazip
    Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath
    
    # Shotcut Variables
    $shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Peazip.lnk")
    $executablePath = [System.IO.Path]::Combine((Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object { $_.BaseName.Contains("peazip_portable") })[0].FullName, "peazip.exe")
    
    # Creating Shortcut
    $WScriptShell = New-Object -ComObject "WScript.Shell"
    $shortcut = $WScriptShell.CreateShortcut($shortcutDestinationPath)
    $shortcut.TargetPath = $executablePath
    $shortcut.Save()
}