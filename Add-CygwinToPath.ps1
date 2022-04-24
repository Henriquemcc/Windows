Import-Module -Name "$($env:ChocolateyInstall)\helpers\chocolateyInstaller.psm1"
Install-ChocolateyPath -PathToInstall "$($env:SystemDrive)\tools\cygwin\bin"