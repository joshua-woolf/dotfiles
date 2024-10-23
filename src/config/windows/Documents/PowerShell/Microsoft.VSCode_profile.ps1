function hosts {
  code (Join-Path $env:SystemRoot "\system32\drivers\etc\hosts")
}

function myip {
	(Invoke-WebRequest "http://ifconfig.me/ip").Content
}

function kubeconfig {
  code (Join-Path $env:USERPROFILE "\.kube\config")
}

function ll {
  Get-ChildItem -Force $args
}

function profile {
  code $PROFILE
}

function q {
  exit
}

function update {
  winget upgrade --all --accept-package-agreements --accept-source-agreements
  Update-Module -AcceptLicense
}

function which {
  param($bin)
	(Get-Command $bin -ErrorAction SilentlyContinue).Definition
}

function Invoke-Starship-PreCommand {
  $current_location = $executionContext.SessionState.Path.CurrentLocation
  if ($current_location.Provider.Name -eq "FileSystem") {
    $ansi_escape = [char]27
    $provider_path = $current_location.ProviderPath -replace "\\", "/"
    $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
  }
  $host.ui.Write($prompt)
}

Invoke-Expression (&starship init powershell)

Set-PSReadLineOption -PredictionViewStyle "ListView"

$prompt = ""

Clear-Host
