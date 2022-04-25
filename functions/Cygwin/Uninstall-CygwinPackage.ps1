function Get-CygwinInstaller
{
    # Getting the path of the Cygwin installer
    $pathCygwinInstaller = [System.IO.Path]::Combine($env:ChocolateyInstall, "lib", "Cygwin", "tools")
    $urlCygwinInstaller
    if ($env:PROCESSOR_ARCHITECTURE -eq "AMD64")
    {
        $pathCygwinInstaller = [System.IO.Path]::Combine($pathCygwinInstaller, "setup-x86_64.exe")
        $urlCygwinInstaller = "https://www.cygwin.com/setup-x86_64.exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE -eq "x86")
    {
        $pathCygwinInstaller = [System.IO.Path]::Combine($pathCygwinInstaller, "setup-x86.exe")
        $urlCygwinInstaller = "https://www.cygwin.com/setup-x86.exe"
    }

    # Downloading Cygwin installer if it does not exist
    if (-not (Test-Path -Path $pathCygwinInstaller))
    {
        New-Item -Path (Split-Path -Path $pathCygwinInstaller -Parent) -ItemType Directory -Force
        Invoke-WebRequest -Uri $urlCygwinInstaller -OutFile $pathCygwinInstaller
    }

    return $pathCygwinInstaller
}

function global:Uninstall-CygwinPackage
{
    param(
        [Parameter(Mandatory = $true)]$Package
    )

    # Converting array to string
    if ($Package -is [System.Array])
    {
        $Package = $Package -join " "
    }

    # Getting the path of Cygwin installer
    $pathCygwinInstaller = Get-CygwinInstaller

    # Creating command string
    $commandString = [System.Text.StringBuilder]::new()
    $commandString.Append($pathCygwinInstaller)
    $commandString.Append("--remove-packages ")
    $commandString.Append($Package)

    # Converting command string from StringBuilder to String
    $commandString = $commandString.ToString()

    # Running command string
    Invoke-Expression -Command $commandString
}