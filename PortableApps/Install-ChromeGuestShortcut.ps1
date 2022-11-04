function Get-ChromeExecutable {

    $chromeExecutableLocations = @(
        [System.IO.Path]::Combine($env:APPDATA, "Google", "Chrome", "Application", "chrome.exe"),
        [System.IO.Path]::Combine($env:ProgramFiles, "Google", "Chrome", "Application", "chrome.exe"),
        [System.IO.Path]::Combine(${env:ProgramFiles(x86)}, "Google", "Chrome", "Application", "chrome.exe")
    )

    foreach ($executable in $chromeExecutableLocations)
    {
        if ([System.IO.File]::Exists($executable))
        {
            return $executable
        }
    }
}

# Creating Shotcut Guest
$WScriptShell = New-Object -ComObject "WScript.Shell"
$shortcut = $WScriptShell.CreateShortcut([System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Chrome Guest.lnk"))
$shortcut.TargetPath = Get-ChromeExecutable
$shortcut.Arguments = "--guest"
$shortcut.Save()