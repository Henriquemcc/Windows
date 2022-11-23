function Get-CygwinInstallerUrl
{
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://www.cygwin.com/setup-x86_64.exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        return "https://www.cygwin.com/setup-x86.exe"
    }
    else {
        throw "Invalid Architecture"
    }
}