Import-Module .\Modules\Install.psm1

$configuration = Get-Content "configuration.json" | ConvertFrom-Json -AsHashTable

Write-InstallLog "Installing Scoop..."

Invoke-RestMethod "get.scoop.sh" | Invoke-Expression

Write-InstallLog "Installing Scoop applications..."

$scoopBuckets = $configuration.AddScoopApplications | Select-Object { $_.Split("/")[0] } | Get-Unique -AsString

$scoopBuckets | ForEach-Object { scoop bucket add "$($_)" }

$configuration.AddScoopApplications | ForEach-Object { scoop install "$($_)" }

Write-InstallLog "Installing WinGet applications..."

$configuration.AddWinGetApplications.User | ForEach-Object { Install-WinGetApplication -Id "$($_.Id)" -Override "$($_.Override)" }
Write-InstallLog "Setting Docker configuration..."

$dockerCniConfigurationPath = "$($env:USERPROFILE)/AppData/Roaming/Docker/cni/10-default.conflist"
(Get-Content $dockerCniConfigurationPath).Replace("10.1.0.", "172.1.0.") | Out-File $dockerCniConfigurationPath

Write-InstallLog "Setting Git configuration..."

git config --global init.defaultBranch $configuration.Applications.Git.DefaultBranch
git config --global user.email $configuration.Applications.Git.Email
git config --global user.name $configuration.Applications.Git.Name

Write-InstallLog "Setting Windows Subsystem for Linux configuration..."

@"
[wsl2]
memory=$($configuration.Applications.WindowsSubsystemForLinux.MemoryLimit)GB
processors=$($configuration.Applications.WindowsSubsystemForLinux.CpuLimit)
"@ | Out-File "$($env:USERPROFILE)/.wslconfig"
