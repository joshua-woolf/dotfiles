# Config

This repository holds some scripts and configuration that I use for setting up my computer.

Before running any of the scripts in the repository, ensure that your PowerShell execution policy is set to allow scripts to run by running the following as Administrator:

```powershell
Set-ExecutionPolicy RemoteSigned -Force
```

The scripts should then be run in the following order:

1. Ensure you update the `configuration.json` with the following values:
   1. `Applications.Git.Email`
   1. `Applications.Git.Name`
   1. `ComputerName`
1. `Installer.Admin.ps1` should be run as administrator.
1. `Installer.User.ps1` should be run as user.

Thereafter some manual installations are done:

- Set Accessibility - Mouse pointer and touch settings.
- Uninstall pinned apps from the start menu that trigger the app installers.
- Install apps manually:
  - [Bias FX 2](https://member.positivegrid.com/license)
  - [M-Audio M-Track Solo Driver](https://m-audio.com/support/download/drivers/m-track-solo-and-duo-windows-driver-v1.0.3)

A few tasks still need to be automated:

- Set PowerShell to launch with the `-nologo` flag in Windows Terminal.
- Set PowerShell profile configuration.
- Set configuration in IDEs:
  - Rider
  - Visual Studio
  - Visual Studio Code
- Set Windows Terminal configuration.
- Set up Windows Subsystem for Linux distribution.
