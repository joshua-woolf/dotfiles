function home {
  code $HOME
}

function hosts {
  code "/etc/hosts"
}

function kubeconfig {
  code (Join-Path $HOME "\.kube\config")
}

function profile {
  code $PROFILE
}

function update {
  /opt/homebrew/bin/brew update && /opt/homebrew/bin/brew upgrade
  Update-Module -AcceptLicense
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

Invoke-Expression (&/opt/homebrew/bin/starship init powershell)

$prompt = ""

Clear-Host
