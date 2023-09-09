Function Write-CustomLog {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)] [string] $Message
  )

  Write-Host $Message -BackgroundColor "Cyan" -ForegroundColor "Black"
}

Function Cleanup {
  Write-CustomLog "Emptying recycle bin..."
  (New-Object -ComObject Shell.Application).Namespace(0xA).Items() | ForEach-Object { Remove-Item $_.Path -Recurse -Confirm:$false }

  Write-CustomLog "Running disk cleanup..."
  Sudo "$(Join-Path $env:SystemRoot 'system32\cleanmgr.exe')" "/sagerun:6174"
}

Function Download {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)] [string] $Uri
  )
  $fileName = [System.IO.Path]::GetFileName($Uri)
  Invoke-WebRequest -Uri $Uri -OutFile $fileName
}

Function Extract {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)] [string] $Archive,
    [Parameter(Position = 1, Mandatory = $true)] [string] $TargetDirectory
  )

  If (-not (Test-Path -Path $TargetDirectory -PathType Container)) {
    New-Item -Path $TargetDirectory -ItemType Directory -Force
  }

  If ($Archive -match '\.zip$') {
    Expand-Archive -Path $Archive -DestinationPath $TargetDirectory -Force
  }
  ElseIf ($Archive -match '\.tar\.gz$') {
    tar -xzf $Archive -C $TargetDirectory
  }
}

Function Get-PublicIpAddress {
  (Invoke-WebRequest "http://ifconfig.me/ip").Content
}

Function Hosts {
  code "$(Join-Path $env:SystemRoot '\system32\drivers\etc\hosts')"
}

Function Profile {
  code $PROFILE
}

Function Sudo {
  If ($args.Length -eq 1) {
    Start-Process $args[0] -Verb "RunAs"
  }
  If ($args.Length -gt 1) {
    Start-Process $args[0] -ArgumentList $args[1..$args.Length] -Verb "RunAs"
  }
}

Function Update {
  Write-CustomLog "Updating Microsoft Store applications..."
  Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod

  Write-CustomLog "Updating WinGet applications..."
  winget upgrade --all --accept-package-agreements --accept-source-agreements

  Write-CustomLog "Updating PowerShell modules..."
  Update-Module

  Import-Module PSWindowsUpdate

  Write-CustomLog "Installing Windows updates..."
  Install-WindowsUpdate -AcceptAll -IgnoreReboot -IgnoreUserInput
}

Function Version {
  $osInfo = (Get-WmiObject Win32_OperatingSystem)
  Write-Host "$($osInfo.Caption) ($($osInfo.Version))"
}

Function Which {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)] [string] $Name
  )

  (Get-Command $Name -ErrorAction SilentlyContinue).Definition
}

oh-my-posh init pwsh --config "https://raw.githubusercontent.com/joshua-woolf/omp-themes/main/grape.omp.json" | Invoke-Expression

Clear-Host
