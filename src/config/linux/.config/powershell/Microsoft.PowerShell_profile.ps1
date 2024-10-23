function hosts {
  code "/etc/hosts"
}

function myip {
  (Invoke-WebRequest "http://ifconfig.me/ip").Content
}

function kubeconfig {
  code (Join-Path $HOME "\.kube\config")
}

function profile {
  code $PROFILE
}

function q {
  exit
}

function update {
  sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y
  sudo snap refresh
  brew update && brew upgrade
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

Invoke-Expression (&starship init powershell)

$prompt = ""

Clear-Host
