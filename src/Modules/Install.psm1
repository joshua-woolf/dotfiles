Function Install-WindowsOptionalFeature {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)] [string] $FeatureName
  )

  Enable-WindowsOptionalFeature -Online -FeatureName $FeatureName -All -NoRestart
}

Function Install-WinGetApplication {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)] [string] $Id,
    [Parameter(Mandatory = $false)] [string] $Override = $null
  )

  If (($null -eq $Override) -or ("" -eq $Override)) {
    winget install --accept-package-agreements --accept-source-agreements --exact --id "$Id"
  }
  Else {
    winget install --accept-package-agreements --accept-source-agreements --exact --id "$Id" --override "$Override"
  }
}

Function Invoke-ExplorerRestart {
  Stop-Process -Name "Explorer" -Force
}

Function Invoke-MicrosoftStoreApplicationUpdates {
  Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod
}

Function Invoke-WinGetApplicationUpdates {
  winget upgrade --all --accept-package-agreements --accept-source-agreements
}

Function Invoke-WindowsUpdates {
  Import-Module PSWindowsUpdate

  Install-WindowsUpdate -AcceptAll -IgnoreReboot -IgnoreUserInput
}

Function Set-RegistryValue {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)] [string] $Path,
    [Parameter(Mandatory = $true)] [string] $Name,
    [Parameter(Mandatory = $true)] [AllowEmptyString()] [string] $Value
  )

  If (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force
  }

  Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force
}

Function Uninstall-AllWindowsOptionalFeatures {
  Get-WindowsOptionalFeature -Online `
  | Where-Object { $_.State -eq "Enabled" } `
  | ForEach-Object { Disable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -NoRestart -WarningAction SilentlyContinue }
}

Function Uninstall-WindowsApplication {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)] [string] $ApplicationName
  )

  Get-AppxPackage $ApplicationName -AllUsers | Remove-AppxPackage -AllUsers
  Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like $ApplicationName | Remove-AppxProvisionedPackage -Online -AllUsers
}

Function Uninstall-WindowsCapability {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)] [string] $CapabilityName
  )

  Remove-WindowsCapability -Online -Name $CapabilityName
}

Function Uninstall-WinGetApplication {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)] [string] $Id
  )

  winget uninstall --accept-source-agreements --exact --id "$Id"
}

Function Write-InstallLog {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)] [string] $Message
  )

  Write-Host $Message -ForegroundColor "Magenta"
}

Export-ModuleMember -Function *
