Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

if (Test-AdministratorPrivileges) {

    # Download Variables
    $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "https://redirector.gvt1.com/edgedl/android/studio/install/2022.1.1.19/android-studio-2022.1.1.19-windows.exe"
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
    $silentInstallArgs = @("/S")

    # Installing Android Studio
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $downloadFilePath
    $process.StartInfo.Arguments = $silentInstallArgs -join " "
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()

}
else {
    # Download Variables
    $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.1.1.19/android-studio-2022.1.1.19-windows.zip"
    }
    else {
        throw "Invalid Architecture"
    }
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)
    
    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath
    
    # Creating Installation Directory
    New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue
    
    # Installation Varibles
    $installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Android Studio")
    
    # Extracting Android Studio
    Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath
    
    # Shotcut Variables
    $shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Android Studio.lnk")
    $executablePath = [System.IO.Path]::Combine((Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object { $_.BaseName.Contains("android-studio") })[0].FullName, "bin", "studio64.exe")
    
    # Creating Shortcut
    $WScriptShell = New-Object -ComObject "WScript.Shell"
    $shortcut = $WScriptShell.CreateShortcut($shortcutDestinationPath)
    $shortcut.TargetPath = $executablePath
    $shortcut.Save()
}

