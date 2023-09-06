Import-Module .\Modules\Install.psm1

$configuration = Get-Content "configuration.json" | ConvertFrom-Json

Test-Configuration -Name "Applications.Git.Email" -Value $configuration.Applications.Git.Email
Test-Configuration -Name "Applications.Git.User" -Value $configuration.Applications.Git.User

Write-InstallLog "Installing Scoop..."

If ($null -eq (Which "scoop")) {
  Invoke-RestMethod "get.scoop.sh" | Invoke-Expression
}
else {
  scoop update
}

Write-InstallLog "Installing Scoop applications..."

$scoopBuckets = @()

$configuration.AddScoopApplications | ForEach-Object { $ScoopBuckets += $_.Split("/")[0] }

$scoopBuckets | Get-Unique -AsString | ForEach-Object { scoop bucket add "$($_)" }

$configuration.AddScoopApplications | ForEach-Object { scoop install "$($_)" }

Write-InstallLog "Installing WinGet applications..."

$configuration.AddWinGetApplications.User | ForEach-Object { Install-WinGetApplication -Id "$($_.Id)" -Override "$($_.Override)" }


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
