$WindowsOptionalFeaturesToAdd = @(
  "Microsoft-Hyper-V-All",
  "Microsoft-Windows-PrintToPDF", # TODO: Can't be found
  "VirtualMachinePlatform",
  "Containers-DisposableClientVM",
  "Microsoft-Windows-Subsystem-Linux"
)

$WindowsOptionalCapabilitiesToRemove = @(
  "App.StepsRecorder",
  "Browser.InternetExplorer",
  "MathRecognizer",
  "Media.WindowsMediaPlayer",
  "Microsoft.Wallpapers.Extended",
  "Microsoft.Windows.Notepad.System",
  "Microsoft.Windows.PowerShell.ISE",
  "Microsoft.Windows.WordPad",
  "OpenSSH.Client",
  "Print.Management.Console"
)

$WindowsAppsToRemove = @(
  "*.AutodeskSketchBook",
  "*.DisneyMagicKingdoms",
  "*.MarchofEmpires",
  "*.SlingTV",
  "*.TikTok",
  "*.Twitter",
  "AdobeSystemsIncorporated.AdobeCreativeCloudExpress",
  "AmazonVideo.PrimeVideo",
  "Clipchamp.Clipchamp",
  "Disney.37853FC22B2CE", # Disney+
  "DolbyLaboratories.DolbyAccess",
  "Facebook.Facebook*",
  "Facebook.Instagram*"
  "king.com.BubbleWitch3Saga",
  "king.com.CandyCrushSodaSaga",
  "Microsoft.3DBuilder",
  "Microsoft.549981C3F5F10", # Cortana
  "Microsoft.BingFinance",
  "Microsoft.BingNews",
  "Microsoft.BingSports",
  "Microsoft.BingWeather",
  "Microsoft.GamingApp",
  "Microsoft.GetStarted",
  "Microsoft.Messaging",
  "Microsoft.MicrosoftOfficeHub",
  "Microsoft.MicrosoftSolitaireCollection",
  "Microsoft.MicrosoftStickyNotes",
  "Microsoft.Office.OneNote",
  "Microsoft.Office.Sway",
  "Microsoft.OneConnect",
  "Microsoft.OneDriveSync",
  "Microsoft.People",
  "Microsoft.Print3D",
  "Microsoft.ScreenSketch",
  "Microsoft.SkypeApp",
  "Microsoft.ToDos",
  "Microsoft.Windows.Photos",
  "Microsoft.WindowsAlarms",
  "Microsoft.WindowsCommunicationsApps",
  "Microsoft.WindowsFeedbackHub",
  "Microsoft.WindowsMaps",
  "Microsoft.WindowsSoundRecorder",
  "Microsoft.XboxGamingOverlay",
  "Microsoft.YourPhone",
  "Microsoft.ZuneMusic",
  "Microsoft.ZuneVideo",
  "MicrosoftTeams",
  "SpotifyAB.SpotifyMusic"
)

$WinGetAppsToRemove = @(
  "Microsoft.OneDrive"
)

$WinGetAppsToAdd = @(
  @{ 
    Id = "9P7KNL5RWT25" # SysInternals Suite
  },
  @{ 
    Id = "9P9TQF7MRM4R" # Windows Subsystem for Linux
  }, 
  @{ 
    Id = "9PDXGNCFSCZV" # Ubuntu
  }, 
  @{ 
    Id = "9PGJGD53TN86" # WinDbg Preview
  }, 
  @{ 
    Id = "9WZDNCRDFNG7" # Hotspot Shield VPN
  }, 
  @{ 
    Id = "7zip.7zip" 
  },
  @{ 
    Id = "Adobe.Acrobat.Reader.64-bit" 
  },
  @{ 
    Id = "ahmetb.kubectx" 
  },
  @{ 
    Id = "ahmetb.kubens" 
  },
  @{ 
    Id = "Amazon.AWSCLI" 
  },
  @{ 
    Id = "Axosoft.GitKraken" 
  },
  @{ 
    Id = "Derailed.k9s" 
  },
  @{ 
    Id = "Docker.DockerDesktop" 
  },
  @{ 
    Id = "Discord.Discord" 
  },
  @{ 
    Id       = "Git.Git"     
    Override = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /SP- /LOG /COMPONENTS=icons,assoc,assoc_sh,ext,ext\shellhere,ext\guihere,windowsterminal /o:BashTerminalOption=ConHost /o:CURLOption=WinSSL /o:EditorOption=VisualStudioCode /o:DefaultBranchOption=main"
  },
  @{ 
    Id = "GitHub.GitHubDesktop" 
  },
  @{ 
    Id = "Google.Chrome" 
  },
  @{ 
    Id = "Google.GoogleDrive" 
  },
  @{ 
    Id = "Hashicorp.Terraform" 
  },
  @{ 
    Id = "Helm.Helm" 
  },
  @{ 
    Id = "JanDeDobbeleer.OhMyPosh" 
  },
  @{ 
    Id       = "JetBrains.dotUltimate"
    Override = "/SpecificProductNames=ReSharper;dotTrace;dotCover;dotPeek;dotMemory;Rider /Silent=True /VsVersion=17.0"
  },
  @{ 
    Id = "jqlang.jq" 
  },
  @{ 
    Id = "Kubernetes.kubectl" 
  },
  @{ 
    Id = "Microsoft.Azure.AZCopy.10" 
  },
  @{ 
    Id = "Microsoft.AzureCLI" 
  },
  @{ 
    Id = "Microsoft.AzureDataStudio" 
  },
  @{ 
    Id = "Microsoft.AzureStorageExplorer" 
  },
  @{ 
    Id = "Microsoft.DotNet.SDK.6" 
  },
  @{ 
    Id = "Microsoft.DotNet.SDK.7" 
  },
  @{ 
    Id = "Microsoft.PowerShell" 
  },
  @{ 
    Id = "Microsoft.PowerToys" 
  },
  @{ 
    Id = "Microsoft.SQLServerManagementStudio" 
  },
  @{ 
    Id = "Microsoft.VCRedist.2012.x64" 
  },
  @{ 
    Id = "Microsoft.VCRedist.2012.x86" 
  },
  @{ 
    Id = "Microsoft.VCRedist.2013.x64" 
  },
  @{ 
    Id = "Microsoft.VCRedist.2013.x86" 
  },
  @{ 
    Id = "Microsoft.VCRedist.2015+.x64" 
  },
  @{ 
    Id = "Microsoft.VCRedist.2015+.x86" 
  },
  @{ 
    Id       = "Microsoft.VisualStudio.2022.Community"
    Override = "--add Microsoft.VisualStudio.Workload.Azure;Microsoft.VisualStudio.Workload.Data;Microsoft.VisualStudio.Workload.ManagedDesktop;Microsoft.VisualStudio.Workload.NetWeb --norestart --passive --wait"
  },
  @{ 
    Id = "Microsoft.VisualStudioCode" 
  },
  @{ 
    Id = "Microsoft.WindowsTerminal" 
  },
  @{ 
    Id = "Nvidia.GeForceExperience" 
  },
  @{ 
    Id = "OpenJS.NodeJS" 
  },
  @{ 
    Id = "qBittorrent.qBittorrent" 
  },
  @{ 
    Id = "Spotify.Spotify" 
  },
  @{ 
    Id = "SteelSeries.GG" 
  },
  @{ 
    Id = "VideoLAN.VLC" 
  }
)

Function Set-RegistryValue {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true)] [string] $Path,
    [Parameter(Position = 1, Mandatory = $true)] [string] $Name,
    [Parameter(Position = 2, Mandatory = $true)] [string] $Value
  )

  If (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force
  }
    
  Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force
}

Function Set-ColorConfiguration {
  # Disable Accent Color on Title Bar
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\DWM" "ColorPrevalence" 0
  # Enable Transparency Effects
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 1
  # Disable Accent Color on Start Menu and Taskbar
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" 0
  # Enable Dark Mode for Apps
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0
  # Enable Dark Mode for System
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0
}

Function Set-ComputerName {
  Rename-Computer -NewName "JWHOME"
}

Function Set-ContextMenuConfiguration {
  Set-RegistryValue "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" "(Default)" ""
}

Function Set-DeveloperModeConfiguration {
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1
}

Function Set-DiskCleanupConfiguration {
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\BranchCache" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\RetailDemo Offline Content" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Service Pack Cleanup" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\User file versions" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Archive Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Queue Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Archive Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Queue Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Temp Files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows ESD installation files" "StateFlags6174" 2
  Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Upgrade Log Files" "StateFlags6174" 2
}

Function Set-FolderOptionsConfiguration {
  # Open File Explorer to This PC
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" 1
  # Show Hidden Files
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1
  # Show File Extensions
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0
  # Show Full Path In Title
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" "FullPath" 1
  # Show Empty Drives
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideDrivesWithNoMedia" 0
}

Function Set-LongPathsConfiguration {
  Set-RegistryValue "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "LongPathsEnabled" 1
}

Function Set-PrivacyConfiguration {
  # Disable Personalized Ads
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
  Remove-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Id" -ErrorAction SilentlyContinue
  # Disable Websites Accessing Language List
  Set-RegistryValue "HKCU:\Control Panel\International\User Profile" "HttpAcceptLanguageOptOut" 1
  # Disable Application Launch Tracking
  Set-RegistryValue "HKCU:\\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start-TrackProgs" 0
  # Disable Suggested Content In Settings
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338393Enabled" 0
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338394Enabled" 0
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338396Enabled" 0
}

Function Set-StartMenuConfiguration {
  # Set Layout to More Pins
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_Layout" 0
  # Hide Recently Added Apps
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" "ShowRecentList" 0
  # Hide Most Used Apps
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" "ShowFrequentList" 0
  # Hide Recently Opened Apps
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_TrackDocs" 0
  # Hide Recommendations, Tips, etc.
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_IrisRecommendations" 0
}

Function Set-TaskbarConfiguration {
  # Hide Search
  Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" 0
  # Hide Task View
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" 0
  # Hide Widgets
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 0
  # Hide Chat
  Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 0
}

Function Invoke-ExplorerRestart {
  Stop-Process -Name "Explorer" -Force
}

Function Set-WindowsConfiguration {
  Set-ColorConfiguration
  Set-ComputerName
  Set-ContextMenuConfiguration
  Set-DeveloperModeConfiguration
  Set-DiskCleanupConfiguration
  Set-FolderOptionsConfiguration
  Set-LongPathsConfiguration
  Set-PrivacyConfiguration
  Set-StartMenuConfiguration
  Set-TaskbarConfiguration
  Invoke-ExplorerRestart
}

Function Remove-WindowsOptionalFeatures {
  Get-WindowsOptionalFeature -Online | Where-Object { $_.State -eq "Enabled" } | ForEach-Object { Disable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -NoRestart -WarningAction SilentlyContinue }    
}

Function Add-WindowsOptionalFeatures {
  ForEach ($featureToAdd In $WindowsOptionalFeaturesToAdd) {
    Enable-WindowsOptionalFeature -Online -FeatureName $featureToAdd -All -NoRestart
  }
}

Function Remove-WindowsOptionalCapabilities {
  $installedCapabilities = Get-WindowsCapability -Online | Where-Object { $_.State -eq "Installed" }

  ForEach ($capability In $installedCapabilities) {
    ForEach ($capabilityToRemove In $WindowsOptionalCapabilitiesToRemove) {
      If ($capability.Name.StartsWith($capabilityToRemove)) {
        Remove-WindowsCapability -Online -Name $capability.Name
        Break
      }
    }
  }
}

Function Invoke-CapabilitiesAndFeaturesConfiguration {
  Remove-WindowsOptionalFeatures
  Remove-WindowsOptionalCapabilities
  Add-WindowsOptionalFeatures
}

Function Remove-WindowsApp {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)] [string] $Name
  )

  Get-AppxPackage $Name -AllUsers | Remove-AppxPackage -AllUsers
  Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like $Name | Remove-AppxProvisionedPackage -Online -AllUsers
}

Function Remove-WindowsApps {
  $WindowsAppsToRemove | ForEach-Object { Remove-WindowsApp $_ }
}

Function Invoke-WinGetInstall {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true)] [string] $Id,
    [Parameter(Position = 1, Mandatory = $false)] [string] $Override = $null
  )

  If (($null -eq $Override) -or ("" -eq $Override)) {
    winget install --accept-package-agreements --accept-source-agreements --exact --id "$Id"
  }
  Else {
    winget install --accept-package-agreements --accept-source-agreements --exact --id "$Id" --override "$Override"
  }
}

Function Invoke-WinGetInstalls {
  $WinGetAppsToAdd | ForEach-Object { Invoke-WinGetInstall "$($_.Id)" "$($_.Override)" }
}

Function Invoke-WinGetUninstall {
  [CmdletBinding()]
  Param (
    [Parameter(Position = 0, Mandatory = $true)] [string] $Id
  )

  winget uninstall --accept-source-agreements --exact --id "$Id"
}

Function Invoke-WinGetUninstalls {
  $WinGetAppsToRemove | ForEach-Object { Invoke-WinGetUninstall "$($_.Id)" }
}

Function Install-PowerShellModules {
  Get-PackageProvider NuGet -Force
  Install-Module Posh-Git -Scope CurrentUser -Force
  Install-Module PSWindowsUpdate -Scope CurrentUser -Force
}

Function Invoke-AppsSetup {
  Invoke-WinGetUninstalls
  Invoke-WinGetInstalls
}

Function Set-DockerConfiguration {
  $configPath = "$($env:USERPROFILE)/AppData/Roaming/Docker/cni/10-default.conflist"
  (Get-Content $configPath).Replace("10.1.0.", "172.1.0.") | Out-File $configPath
}

Function Set-GitConfiguration {
  git config --global init.defaultBranch "main"
  git config --global user.email "joshuawoolf87@gmail.com"
  git config --global user.name "Joshua Woolf"
}

Function Set-WslConfiguration {
  @"
[wsl2]
memory=8GB
processors=2
"@ | Out-File "$($env:USERPROFILE)/.wslconfig"
}

Function Set-AppsConfiguration {
  Set-DockerConfiguration
  Set-GitConfiguration
  Set-WslConfiguration
}

Function Invoke-MicrosoftStoreAppsUpdate {
  Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod
}

Function Invoke-PowerShellModulesUpdate {
  Update-Module
}

Function Invoke-WindowsUpdate {
  Import-Module PSWindowsUpdate
  Install-WindowsUpdate -AcceptAll -IgnoreReboot -IgnoreUserInput
}

Function Invoke-WinGetAppsUpdate {
  winget upgrade --all --accept-package-agreements --accept-source-agreements
}

Function Invoke-Updates {
  Invoke-MicrosoftStoreAppsUpdate
  Invoke-PowerShellModulesUpdate
  Invoke-WindowsUpdate
  Invoke-WinGetAppsUpdate
}

Function Invoke-Setup {
  Install-PowerShellModules
  Set-WindowsConfiguration
  Remove-WindowsApps
  Invoke-CapabilitiesAndFeaturesConfiguration
  Invoke-Updates
  Invoke-AppsSetup
  Set-AppsConfiguration
}
  
Invoke-Setup

# TODO: Set accessibility mouse pointer and touch configuration.
# TODO: Uninstall pinned apps.
# TODO: Manual installation of M-Audio drivers (https://m-audio.com/support/download/drivers/m-track-solo-and-duo-windows-driver-v1.0.3).
# TODO: Manual installation of Bias FX 2 (https://member.positivegrid.com/license).
# TODO: Set PowerShell to launch with -nologo flag.
# TODO: Set PowerShell profile.