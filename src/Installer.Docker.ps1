Import-Module $PSScriptRoot\Modules\Install.psm1

Write-InstallLog "Setting Docker configuration..."

$dockerCniConfigurationPath = "$($env:USERPROFILE)/AppData/Roaming/Docker/cni/10-default.conflist"
(Get-Content $dockerCniConfigurationPath).Replace("10.1.0.", "172.1.0.") | Out-File $dockerCniConfigurationPath
