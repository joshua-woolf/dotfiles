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

Set-RegistryValue -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value ""
