Import-Module .\Modules\Install.psm1
Import-Module .\Modules\WindowsConfiguration.psm1

$configuration = Get-Content "configuration.json" | ConvertFrom-Json

Write-InstallLog "Adding NuGet package provider..."

Get-PackageProvider NuGet -Force

Write-InstallLog "Installing PowerShell modules..."

Install-Module Posh-Git -Scope CurrentUser -Force
Install-Module PSWindowsUpdate -Scope CurrentUser -Force

Write-InstallLog "Configuring Windows..."

Enable-AllDiskCleanupOptions
Enable-LegacyContextMenu
Enable-LongPaths
Set-ComputerName -ComputerName $configuration.ComputerName
Set-FileExplorerFolderOptionsSettings
Set-PersonalizationColorSettings
Set-PersonalizationStartSettings
Set-PersonalizationTaskbarSettings
Set-PrivacyAndSecurityForDevelopersSettings
Set-PrivacyAndSecurityGeneralSettings

Write-InstallLog "Restarting Explorer..."

Invoke-ExplorerRestart

Write-InstallLog "Uninstalling Windows applications..."

$configuration.RemoveWindowsApplications | ForEach-Object { Uninstall-WindowsApplication -ApplicationName "$($_)" }

Write-InstallLog "Uninstalling Windows optional capabilities..."

ForEach ($installedCapability In (Get-WindowsCapability -Online | Where-Object { $_.State -eq "Installed" })) {
  ForEach ($capability In $configuration.RemoveWindowsOptionalCapabilities) {
    If ($installedCapability.Name.StartsWith($capability)) {
      Remove-WindowsCapability -Online -Name $installedCapability.Name
      Break
    }
  }
}

Write-InstallLog "Uninstalling Windows optional features..."

Uninstall-AllWindowsOptionalFeatures

Write-InstallLog "Installing Windows optional features..."

$configuration.AddWindowsOptionalFeatures | ForEach-Object { Install-WindowsOptionalFeature -FeatureName "$($_)" }

Write-InstallLog "Invoke Microsoft Store application updates..."

Invoke-MicrosoftStoreApplicationUpdates

Write-InstallLog "Invoke WinGet application updates..."

Invoke-WinGetApplicationUpdates

Write-InstallLog "Invoke Windows updates..."

Invoke-WindowsUpdates

Write-InstallLog "Uninstalling WinGet applications..."

$configuration.RemoveWinGetApplications | ForEach-Object { Uninstall-WinGetApplication -Id "$($_)" }

Write-InstallLog "Installing WinGet applications..."

$configuration.AddWinGetApplications.Admin | ForEach-Object { Install-WinGetApplication -Id "$($_.Id)" -Override "$($_.Override)" }
Write-InstallLog "Setting Docker configuration..."

