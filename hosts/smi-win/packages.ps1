$packages = @(
    "7zip.7zip",

    # A
    "Axosoft.GitKraken",

    # B
    "Bitwarden.Bitwarden",

    # C
    "CodeSector.TeraCopy",
    "CrystalDewWorld.CrystalDiskInfo",

    # D
    "Discord.Discord",
    "Docker.DockerDesktop",
    
    # E
    "EpicGames.EpicGamesLauncher",

    # F
    "FilenCloud.FilenSync",

    # G
    "Git.Git",

    # H
    
    # I
    "IrfanSkiljan.IrfanView",
    
    # J

    # K
    "KeePassXCTeam.KeePassXC",

    # L
    "Logitech.GHUB",

    # M
    "Mozilla.Firefox",
    "MullvadVPN.MullvadVPN",
    "Microsoft.PowerToys",

    # N

    # O
    "OpenJS.NodeJS",
    "Oracle.VirtualBox",
    "Obsidian.Obsidian",

    # P
    # Q

    # R
    "RevoUninstaller.RevoUninstaller",
    "RiotGames.Valorant.EU",
    "RustDesk.RustDesk",
    "REALiX.HWiNFO",

    # S
    "Safing.Portmaster",

    # T
    "Tailscale.Tailscale",
    
    # U

    # V
    "Valve.Steam",
    "VSCodium.VSCodium",
    "VideoLAN.VLC",
    
    # W
    # X
    
    # Y
    "Yubico.Authenticator"

    # Z
)

$manual_packages = @(
    'Corsair iCUE 5',
    'Drawboard (PDF)',
    'Discord',
    'FanControl',
    'Medal',
    'Samsung Magician',
    'Syncthing',
    'Spicetify',
    'VirtualBox Extension Pack'
    'Office 365'
)

foreach ($pkg in $packages) {
    Write-Host "`n> installing package: $pkg" -ForegroundColor Cyan

    # Check if package is already installed via winget
    $installed = winget list --id $pkg 2>$null
    if ($isInstalled) {
        Write-Host "> $pkg already installed; skipping to the next package." -ForegroundColor Red
    } else {
        winget install --id $pkg --silent --accept-source-agreements --accept-package-agreements
    }
}

# Display a list of applications which have to be installed manually
Write-Host "`n> manual install: $($manual_packages -join ', ')" -ForegroundColor Green