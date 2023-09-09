Function Install-WindowsOptionalFeature {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)] [string] $FeatureName
  )

  Enable-WindowsOptionalFeature -Online -FeatureName $FeatureName -All -NoRestart | Out-Null
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

Function Remove-DesktopShortcuts {
  Remove-Item "C:\Users\$($env:USERNAME)\OneDrive\Desktop\*.lnk" -Force
  Remove-Item "C:\Users\Public\Desktop\*.lnk" -Force
}

Function Set-NvidiaControlPanelConfiguration {
  Copy-Item -Path "$PSScriptRoot\..\Configurations\NvidiaControlPanel\nvdrsdb0.bin" -Destination "C:\ProgramData\NVIDIA Corporation\Drs\nvdrsdb0.bin" -Force
  Copy-Item -Path "$PSScriptRoot\..\Configurations\NvidiaControlPanel\nvdrsdb1.bin" -Destination "C:\ProgramData\NVIDIA Corporation\Drs\nvdrsdb1.bin" -Force1
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

Function Test-Configuration {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)] [string] $Name,
    [Parameter(Mandatory = $false)] [string] $Value
  )

  If (($null -eq $Value) -or ("" -eq $Value))
  {
    Write-Error "The configuration value $($Name) has not been configured. Please update configuration and rerun."
    Exit 1
  }
}

Function Uninstall-AllWindowsOptionalFeatures {
  Get-WindowsOptionalFeature -Online `
  | Where-Object { $_.State -eq "Enabled" } `
  | ForEach-Object { Disable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -NoRestart -WarningAction SilentlyContinue | Out-Null }
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

Function Which {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)] [string] $Name
  )

  (Get-Command $Name -ErrorAction SilentlyContinue).Definition
}

Function Write-InstallLog {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)] [string] $Message
  )

  Write-Host $Message -BackgroundColor "Magenta" -ForegroundColor "Black"
}

Export-ModuleMember -Function *
