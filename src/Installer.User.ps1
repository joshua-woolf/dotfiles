Import-Module .\Modules\Install.psm1

$configuration = Get-Content "configuration.json" | ConvertFrom-Json -AsHashTable

Write-InstallLog "Installing Scoop..."

Invoke-RestMethod "get.scoop.sh" | Invoke-Expression

Write-InstallLog "Installing Scoop applications..."

$scoopBuckets = $configuration.AddScoopApplications | Select-Object { $_.Split("/")[0] } | Get-Unique -AsString

$scoopBuckets | ForEach-Object { scoop bucket add "$($_)" }

$configuration.AddScoopApplications | ForEach-Object { scoop install "$($_)" }
