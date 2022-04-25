Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "Install-Chocolatey.ps1"))

function Install-ChocolateyPackage
{
    param(
        [Parameter(Mandatory = $false)]$Package,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$Help,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$Trace,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$NoColor,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$AcceptLicense,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$Yes,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$Confirm,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$Force,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$NoOp,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$WhatIf,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$LimitOutput,
        [Parameter(Mandatory = $false)]$ExecutionTimeout,
        [Parameter(Mandatory = $false)]$CacheLocation,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$AllowUnofficialBuild,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$FailOnStandardError,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$UseSystemPowerShell,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$NoProgress,
        [Parameter(Mandatory = $false)]$Proxy,
        [Parameter(Mandatory = $false)]$ProxyUser,
        [Parameter(Mandatory = $false)]$ProxyPassword,
        [Parameter(Mandatory = $false)]$ProxyBypassList,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$ProxyBypassOnLocal,
        [Parameter(Mandatory = $false)]$LogFile,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$SkipCompatibilityChecks,
        [Parameter(Mandatory = $false)]$Source,
        [Parameter(Mandatory = $false)]$Version,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$PreRelease,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$x86,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$ForceX86,
        [Parameter(Mandatory = $false)]$InstallArguments,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$OverrideArguments,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$NotSilent,
        [Parameter(Mandatory = $false)]$PackageParameters,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$ApplyInstallArgumentsToDependencies,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$ApplyPackageParametersToDependencies,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$AllowDowngrade,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$AllowMultipleVersions,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$IgnoreDependencies,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$ForceDependencies,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$SkipPowerShell,
        [Parameter(Mandatory = $false)]$User,
        [Parameter(Mandatory = $false)]$Password,
        [Parameter(Mandatory = $false)]$ClientCertificate,
        [Parameter(Mandatory = $false)]$CertificatePassword,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$IgnoreChecksums,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$AllowEmptyChecksums,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$AllowEmptyChecksumsSecure,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$RequireChecksums,
        [Parameter(Mandatory = $false)]$DownloadChecksum,
        [Parameter(Mandatory = $false)]$DownloadChecksum64bit,
        [Parameter(Mandatory = $false)]$DownloadChecksumType,
        [Parameter(Mandatory = $false)]$DownloadChecksumType64bit,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$IgnorePackageExitCodes,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$UsePackageExitCodes,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$StopOnFirstPackageFailure,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$ExitWhenRebootDetected,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$IgnoreDetectedReboot,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$DisablePackageRepositoryOptimizations
    )

    # Installing Chocolatey
    Install-Chocolatey

    # Converting array to string
    if ($Package -is [System.Array])
    {
        $Package = $Package -join " "
    }

    if ($ProxyBypassList -is [System.Array])
    {
        $ProxyBypassList = $ProxyBypassList -join " "
    }

    if ($InstallArguments -is [System.Array])
    {
        $InstallArguments = $InstallArguments -join " "
    }

    if ($PackageParameters -is [System.Array]) {
        $PackageParameters = $PackageParameters -join " "
    }

    # Creating command string
    $commandString = [System.Text.StringBuilder]::new()
    $commandString.Append("choco install ")
    $commandString.Append($Package)

    if ($Help)
    {
        $commandString.Append(" --help")
    }

    if ($Debug)
    {
        $commandString.Append(" --debug")
    }

    if ($Verbose)
    {
        $commandString.Append(" --verbose")
    }

    if ($Trace)
    {
        $commandString.Append(" --trace")
    }

    if ($NoColor)
    {
        $commandString.Append(" --no-color")
    }

    if ($AcceptLicense)
    {
        $commandString.Append(" --accept-license")
    }

    if ($Yes -or $Confirm)
    {
        $commandString.Append(" --confirm")
    }

    if ($Force)
    {
        $commandString.Append(" --force")
    }

    if ($NoOp -or $WhatIf)
    {
        $commandString.Append(" --what-if")
    }

    if ($LimitOutput)
    {
        $commandString.Append(" --limit-output")
    }

    if ($ExecutionTimeout)
    {
        $commandString.Append(" --execution-timeout=$ExecutionTimeout")
    }

    if ($CacheLocation)
    {
        $commandString.Append(" --cache-location=$CacheLocation")
    }

    if ($AllowUnofficialBuild)
    {
        $commandString.Append(" --allow-unofficial-build")
    }

    if ($FailOnStandardError)
    {
        $commandString.Append(" --fail-on-standard-error")
    }

    if ($UseSystemPowerShell)
    {
        $commandString.Append(" --use-system-powershell")
    }

    if ($NoProgress)
    {
        $commandString.Append(" --no-progress")
    }

    if ($Proxy)
    {
        $commandString.Append(" --proxy=$Proxy")
    }

    if ($ProxyUser)
    {
        $commandString.Append(" --proxy-user=$ProxyUser")
    }

    if ($ProxyPassword)
    {
        $commandString.Append(" --proxy-password=$ProxyPassword")
    }

    if ($ProxyBypassList)
    {
        $commandString.Append(" --proxy-bypass-list=$ProxyBypassList")
    }

    if ($ProxyBypassOnLocal)
    {
        $commandString.Append(" --proxy-bypass-on-local")
    }

    if ($LogFile)
    {
        $commandString.Append(" --log-file=$LogFile")
    }

    if ($SkipCompatibilityChecks)
    {
        $commandString.Append(" --skip-compatibility-checks")
    }

    if ($Source)
    {
        $commandString.Append(" --source=$Source")
    }

    if ($Version)
    {
        $commandString.Append(" --version=$Version")
    }

    if ($PreRelease)
    {
        $commandString.Append(" --prerelease")
    }

    if ($x86 -or $ForceX86)
    {
        $commandString.Append(" --forcex86")
    }

    if ($InstallArguments)
    {
        $commandString.Append(" --install-arguments=$InstallArguments")
    }

    if ($OverrideArguments)
    {
        $commandString.Append(" --override-arguments")
    }

    if ($NotSilent)
    {
        $commandString.Append(" --not-silent")
    }

    if ($PackageParameters)
    {
        $commandString.Append(" --package-parameters=$PackageParameters")
    }

    if ($ApplyInstallArgumentsToDependencies)
    {
        $commandString.Append(" --apply-install-arguments-to-dependencies")
    }

    if ($ApplyPackageParametersToDependencies)
    {
        $commandString.Append(" --apply-package-parameters-to-dependencies")
    }

    if ($AllowDowngrade)
    {
        $commandString.Append(" --allow-downgrade")
    }

    if ($AllowMultipleVersions)
    {
        $commandString.Append(" --allow-multiple-versions")
    }

    if ($IgnoreDependencies)
    {
        $commandString.Append(" --ignore-dependencies")
    }

    if ($ForceDependencies)
    {
        $commandString.Append(" --force-dependencies")
    }

    if ($SkipPowerShell)
    {
        $commandString.Append(" --skip-powershell")
    }

    if ($User)
    {
        $commandString.Append(" --user=$User")
    }

    if ($Password)
    {
        $commandString.Append(" --password=$Password")
    }

    if ($ClientCertificate)
    {
        $commandString.Append(" --cert=$ClientCertificate")
    }

    if ($CertificatePassword)
    {
        $commandString.Append(" --certpassword=$ClientCertificate")
    }

    if ($IgnoreChecksums)
    {
        $commandString.Append(" --ignore-checksums")
    }

    if ($AllowEmptyChecksums)
    {
        $commandString.Append(" --allow-empty-checksums")
    }

    if ($AllowEmptyChecksumsSecure)
    {
        $commandString.Append(" --allow-empty-checksums-secure")
    }

    if ($RequireChecksums)
    {
        $commandString.Append(" --require-checksums")
    }

    if ($DownloadChecksum)
    {
        $commandString.Append(" --download-checksum=$DownloadChecksum")
    }

    if ($DownloadChecksum64bit)
    {
        $commandString.Append(" --download-checksum-x64=$DownloadChecksum64bit")
    }

    if ($DownloadChecksumType)
    {
        $commandString.Append(" --download-checksum-type=$DownloadChecksumType")
    }

    if ($DownloadChecksumType64bit)
    {
        $commandString.Append(" --download-checksum-type-x64=$DownloadChecksumType64bit")
    }

    if ($IgnorePackageExitCodes)
    {
        $commandString.Append(" --ignore-package-exit-codes")
    }

    if ($UsePackageExitCodes)
    {
        $commandString.Append(" --use-package-exit-codes")
    }

    if ($StopOnFirstPackageFailure)
    {
        $commandString.Append(" --stop-on-first-package-failure")
    }

    if ($ExitWhenRebootDetected)
    {
        $commandString.Append(" --exit-when-reboot-detected")
    }

    if ($IgnoreDetectedReboot)
    {
        $commandString.Append(" --ignore-detected-reboot")
    }

    if ($DisablePackageRepositoryOptimizations)
    {
        $commandString.Append(" --disable-package-repository-optimizations")
    }

    # Converting command string from StringBuilder to String
    $commandString = $commandString.ToString()

    # Running command string
    Invoke-Expression -Command $commandString
}