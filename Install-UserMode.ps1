$ScoopAppsToAdd = @(
  "extras/openrgb"
  "nerd-fonts/Cascadia-Code"
  "nerd-fonts/CascadiaCode-NF"
  "nerd-fonts/CascadiaCode-NF-Mono"
)

Function Install-Scoop {
  Invoke-RestMethod "get.scoop.sh" | Invoke-Expression
}
  
Function Add-ScoopBucket {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)] [string] $Id
  )
  
  scoop bucket add "$Id"
}
  
Function Install-ScoopApp {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)] [string] $Id
  )
  
  scoop install "$Id"
}
  
Function Install-ScoopApps {
  $buckets = $ScoopAppsToAdd | Select-Object { $_.Split("/")[0] } | Get-Unique -AsString
  $buckets | ForEach-Object { Add-ScoopBucket $_ }
  $ScoopAppsToAdd | ForEach-Object { Install-ScoopApp $_ }
}

Install-Scoop
Install-ScoopApps