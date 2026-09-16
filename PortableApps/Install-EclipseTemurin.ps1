param (
    # JDK Version
    [Parameter(Mandatory = $false)][System.Int16]$Version = 25,
    [Parameter(Mandatory = $false)][Architecture]$Architecture,
    [Parameter(Mandatory = $false)][InstallerType]$InstallerType,
    [Parameter(Mandatory = $false)][string]$JDKType = "JDK",
)

Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

enum Architecture {
    x64
    x86
    aarch64
}

enum InstallerType {
    MSI
    ZIP
}

enum JDKType {
    JDK
    JRE
}

class EclipseTemurinInstaller {
    [System.Int16]$Version
    [Architecture]$Architecture
    [InstallerType]$InstallerType
    [JDKType]$JDKType
    [string]$DownloadUrl
    [string]$Checksum
    

    EclipseTemurinInstaller([System.Int16]$version, [Architecture]$architecture, [JDKType]$JDKType, [string]$downloadUrl, [string]$checksum) {
        $this.Version = $version
        $this.Architecture = $architecture
        $this.DownloadUrl = $downloadUrl
        $this.Checksum = $checksum
        $this.InstallerType = if ($this.DownloadUrl.EndsWith(".msi")) { InstallerType::MSI } else { InstallerType::ZIP }
        $this.JDKType = $JDKType
    }

    [void] Install() {

        # Downloading the installer
        $downloadFileName = [System.IO.Path]::GetFileName($this.DownloadUrl)
        $downloadDirectoryPath = $env:TMP
        $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)
        Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

        # Checking checksum
        if ($this.Checksum) {
            $downloadedFileChecksum = (Get-FileHash -Path:$downloadFilePath -Algorithm SHA256).Hash
            if ($downloadedFileChecksum -ne $this.Checksum) {
                throw "Checksum verification failed for the downloaded file."
            }
        }

        if ($this.InstallerType -eq InstallerType::MSI) {
            # Installing Eclipse Temurin using MSI
            $silentInstallArgs = @("/i", "`"$downloadFilePath`"", "/qn", "/norestart")
            $process = [System.Diagnostics.Process]::new()
            $process.StartInfo.FileName = [System.IO.Path]::Combine($env:windir, "System32", "msiexec.exe")
            $process.StartInfo.Arguments = $silentInstallArgs -join " "
            $process.StartInfo.UseShellExecute = $true
            $process.Start()
            $process.WaitForExit()
        }
        else {
            # Installing Eclipse Temurin using ZIP
            $installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", [System.IO.Path]::GetFileNameWithoutExtension($downloadFileName))
            New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue
            Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

            # Adding to path
            $javaHomePath = (Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object { $_.BaseName.Contains("jdk") })[0].FullName
            $binFolderPath = [System.IO.Path]::Combine($javaHomePath, "bin")

            $envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
            if ($envPath.Length -gt 0 -and (-not $envPath.EndsWith(";"))) {
                $envPath += ";"
            }
            $envPath += $binFolderPath
            [System.Environment]::SetEnvironmentVariable("Path", $envPath, [System.EnvironmentVariableTarget]::User)
        }
    }
}

$installers = @(

    # Eclipse Temurin 8 JDK
    EclipseTemurinInstaller::new(8, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u504-b01/OpenJDK8U-jdk_x64_windows_hotspot_8u504b01.msi", "5115720df210f3c98b592ea2cb9981f48ba6b6942a7c40ba7fe4a59c37d5b815"),
    EclipseTemurinInstaller::new(8, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u504-b01/OpenJDK8U-jdk_x64_windows_hotspot_8u504b01.zip", "ea43d46ede95b51e44a12c66711706cddc762e0a766c54bccea18954e902b2aa", ),
    EclipseTemurinInstaller::new(8, [Architecture]::x86, [JDKType]::JDK, "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u472-b08/OpenJDK8U-jdk_x86-32_windows_hotspot_8u472b08.msi", "daff0b3a7892ec99635f54554070ede99c175c157f683bc99c6d9008e81dfe4f"),
    EclipseTemurinInstaller::new(8, [Architecture]::x86, [JDKType]::JDK, "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u472-b08/OpenJDK8U-jre_x86-32_windows_hotspot_8u472b08.zip", "15df042dcb03bac23a0b2d8d010bf26c49e1247a9a7b58deea19c85d29039f2d"),

    # Eclipse Temurin 8 JRE
    EclipseTemurinInstaller::new(8, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u504-b01/OpenJDK8U-jre_x64_windows_hotspot_8u504b01.msi", "087a67240cd659a35dd894ee1201ec1f989e244cbe29500f4fc0f00443850d09"),
    EclipseTemurinInstaller::new(8, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u504-b01/OpenJDK8U-jre_x64_windows_hotspot_8u504b01.zip", "82e2cdc6693737c5998445b31f69668fa0da77c7705121053f6508ac84961123"),
    EclipseTemurinInstaller::new(8, [Architecture]::x86, [JDKType]::JRE, "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u472-b08/OpenJDK8U-jre_x86-32_windows_hotspot_8u472b08.msi", "a469a375c2a2358dd86bdfbb8237756c3897f6c4259af7418b0bd626a259e360"),
    EclipseTemurinInstaller::new(8, [Architecture]::x86, [JDKType]::JRE, "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u472-b08/OpenJDK8U-jre_x86-32_windows_hotspot_8u472b08.zip", "15df042dcb03bac23a0b2d8d010bf26c49e1247a9a7b58deea19c85d29039f2d"),

    # Eclipse Temurin 11 JDK
    EclipseTemurinInstaller::new(11, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.32.1%2B1/OpenJDK11U-jdk_x64_windows_hotspot_11.0.32.1_1.msi", "253989adc3097a52f81560e32986d829bdec6b949b4595a3489220f74d801cdb"),
    EclipseTemurinInstaller::new(11, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.32.1%2B1/OpenJDK11U-jdk_x64_windows_hotspot_11.0.32.1_1.zip", "d5008f02174c1ad21c10407cbf104815cb390ec4c263d53946e8d0507d7a77f9"),
    EclipseTemurinInstaller::new(11, [Architecture]::x86, [JDKType]::JDK, "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.29%2B7/OpenJDK11U-jdk_x86-32_windows_hotspot_11.0.29_7.msi", "0b2e49c16d02659e3232a8d3ed4936df8a12af1ff34a87204430da8c3de4ac31"),
    EclipseTemurinInstaller::new(11, [Architecture]::x86, [JDKType]::JDK, "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.29%2B7/OpenJDK11U-jdk_x86-32_windows_hotspot_11.0.29_7.zip", "0b5bb836546f86aab9ffe53a14ae51f4801c5a020383d7ea88a054091676698c"),

    # Eclipse Temurin 11 JRE
    EclipseTemurinInstaller::new(11, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.32.1%2B1/OpenJDK11U-jre_x64_windows_hotspot_11.0.32.1_1.msi", "2ee24ab2946b0454463bb38f5d9b2d7e4d2620af7f4fb46df6f313f32635ccdd"),
    EclipseTemurinInstaller::new(11, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.32.1%2B1/OpenJDK11U-jre_x64_windows_hotspot_11.0.32.1_1.zip", "f8c7da672f5dba36b6f870608820b6b598cfae91296929f1b8f21ef2f1e8a0dd"),
    EclipseTemurinInstaller::new(11, [Architecture]::x86, [JDKType]::JRE, "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.29%2B7/OpenJDK11U-jre_x86-32_windows_hotspot_11.0.29_7.msi", "dec292e1d6e90944d0c4592e3df26d19072025ed34657d67d3456281f7f3026a"),
    EclipseTemurinInstaller::new(11, [Architecture]::x86, [JDKType]::JRE, "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.29%2B7/OpenJDK11U-jre_x86-32_windows_hotspot_11.0.29_7.zip", "b747698a05a39391a58b9caac30310275e4e6bd9fef92d6c149cba310d91d2be"),

    # Eclipse Temurin 17 JDK
    EclipseTemurinInstaller::new(17, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.20.1%2B1/OpenJDK17U-jdk_x64_windows_hotspot_17.0.20.1_1.msi", "a6013774c5e4a34951e11c1997d8b4641d2de7736d3eac839231f4266bd1116f"),
    EclipseTemurinInstaller::new(17, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.20.1%2B1/OpenJDK17U-jdk_x64_windows_hotspot_17.0.20.1_1.zip", "e53a79c3c3d86865bd7e787903884331068e71321714ffd44f145785affc7cb0"),
    EclipseTemurinInstaller::new(17, [Architecture]::x86, [JDKType]::JDK, "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17%2B10/OpenJDK17U-jdk_x86-32_windows_hotspot_17.0.17_10.msi", "45a765d3f65f7bff4f98d0361296b301e04b3a44a06bc22203513f8b1ec328bb"),
    EclipseTemurinInstaller::new(17, [Architecture]::x86, [JDKType]::JDK, "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17%2B10/OpenJDK17U-jdk_x86-32_windows_hotspot_17.0.17_10.zip", "34ecb7e53b87ecb288be113ad1c76f3e55e7dc2f2b32427605e356feac95cb74"),

    # Eclipse Temurin 17 JRE
    EclipseTemurinInstaller::new(17, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.20.1%2B1/OpenJDK17U-jre_x64_windows_hotspot_17.0.20.1_1.msi", "fd45e1710b0fe80c08a5141109cc0128e45cefe8c15c3639ce13c564df634031"),
    EclipseTemurinInstaller::new(17, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.20.1%2B1/OpenJDK17U-jre_x64_windows_hotspot_17.0.20.1_1.zip", "bc21a93923103cdaac93ee337b0ae4365e739fde36df823dd456bc67c8a9d352"),
    EclipseTemurinInstaller::new(17, [Architecture]::x86, [JDKType]::JRE, "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17%2B10/OpenJDK17U-jre_x86-32_windows_hotspot_17.0.17_10.msi", "7aa6462a0d258f21d1bf324a80a2eb5ab8fa7707fd520b875f5c129d45c3ac92"),
    EclipseTemurinInstaller::new(17, [Architecture]::x86, [JDKType]::JRE, "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17%2B10/OpenJDK17U-jre_x86-32_windows_hotspot_17.0.17_10.zip", "89ece1b874eea3107aee11e0bd3370e3b40e45838786540dfd9f73e03ed3787b"),

    # Eclipse Temurin 21 JDK
    EclipseTemurinInstaller::new(21, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.12.1%2B1/OpenJDK21U-jdk_x64_windows_hotspot_21.0.12.1_1.msi", "454cfd334b9ca91c96dd8c2de97fcef6b9f1f98be9172ff076711f1c6b44e4e0"),
    EclipseTemurinInstaller::new(21, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.12.1%2B1/OpenJDK21U-jdk_x64_windows_hotspot_21.0.12.1_1.zip", "f9d6e191ab098c0d416e7d588a24420a8621cd2f4720dab2459b8b7b2d2d8b4e"),
    EclipseTemurinInstaller::new(21, [Architecture]::aarch64, [JDKType]::JDK, "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.12.1%2B1/OpenJDK21U-jdk_aarch64_windows_hotspot_21.0.12.1_1.msi", "09efd3d5c12ed56dc80e3602ad36ee28b0bfd6abb3f516e992d0adac84af769f"),
    EclipseTemurinInstaller::new(21, [Architecture]::aarch64, [JDKType]::JDK, "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.12.1%2B1/OpenJDK21U-jdk_aarch64_windows_hotspot_21.0.12.1_1.zip", "ccf2e51f527d542a70ba5794a600d3aac04b4e967950e227834c7566cb1bec7b"),

    # Eclipse Temurin 21 JRE
    EclipseTemurinInstaller::new(21, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.12.1%2B1/OpenJDK21U-jre_x64_windows_hotspot_21.0.12.1_1.msi", "536eeb1dc3f743e5932a92e3549430fc75392c5d379101c1456a1c201aa6e66b"),
    EclipseTemurinInstaller::new(21, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.12.1%2B1/OpenJDK21U-jre_x64_windows_hotspot_21.0.12.1_1.zip", "d35f31e712f0fcf6ac5a093edc90204fbff22f720ba3950bd09d331d5e621636"),
    EclipseTemurinInstaller::new(21, [Architecture]::aarch64, [JDKType]::JRE, "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.12.1%2B1/OpenJDK21U-jre_aarch64_windows_hotspot_21.0.12.1_1.msi", "b46b6cfc621961d7de2e503c47c87fdbcf037a090450b14cc5de09f4ef613ff2"),
    EclipseTemurinInstaller::new(21, [Architecture]::aarch64, [JDKType]::JRE, "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.12.1%2B1/OpenJDK21U-jre_aarch64_windows_hotspot_21.0.12.1_1.zip", "e82cc17e0bf89a25b0b0ed106d072f2ea420587d0a6870534b71b1dce3ae28c3"),

    # Eclipse Temurin 25 JDK
    EclipseTemurinInstaller::new(25, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25.0.4.1%2B1/OpenJDK25U-jdk_x64_windows_hotspot_25.0.4.1_1.msi", "517b3590be43120c34c3891d09c97a1eddc12da982208c4f5adf1bdc1b5e3f15"),
    EclipseTemurinInstaller::new(25, [Architecture]::x64, [JDKType]::JDK, "https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25.0.4.1%2B1/OpenJDK25U-jdk_x64_windows_hotspot_25.0.4.1_1.zip", "00c847d804f4a78e9f04f2683faf14fed898535b177b7fc704486cb0284e9283"),

    # Eclipse Temurin 25 JRE
    EclipseTemurinInstaller::new(25, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25.0.4.1%2B1/OpenJDK25U-jre_x64_windows_hotspot_25.0.4.1_1.msi", "0b3b2550b36b8997be76c70f15b6afd29a0631622ea134c973a6c8180859a56b"),
    EclipseTemurinInstaller::new(25, [Architecture]::x64, [JDKType]::JRE, "https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25.0.4.1%2B1/OpenJDK25U-jre_x64_windows_hotspot_25.0.4.1_1.zip", "4c95451cea98556def2c54f7782933f52a26d4a36bd85e1d59f0364464828b07"),
)

# Obtendo arquitetura do sistema se não for fornecida
if ($Architecture -eq $null) {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        $Architecture = [Architecture]::x64
    } elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        $Architecture = [Architecture]::x86
        $Version = 8
    } elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        $Architecture = [Architecture]::aarch64
    } else {
        throw "Invalid Architecture"
    }    
}

# Obtendo o tipo de instalador se não for fornecido
if ($InstallerType -eq $null) {
    if (Test-AdministratorPrivileges) {
        $InstallerType = InstallerType::MSI
    } else {
        $InstallerType = InstallerType::ZIP
    }
}

# Obtendo o instalador
$instalador = $installers | Where-Object { $_.Version -eq $Version -and $_.Architecture -eq $Architecture -and $_.InstallerType -eq $InstallerType -and $_.JDKType -eq $JDKType }

# Realizando instalação
$instalador.Install()