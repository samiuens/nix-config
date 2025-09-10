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
    "JanDeDobbeleer.OhMyPosh",

    # K
    "KeePassXCTeam.KeePassXC",

    # L
    "Logitech.GHUB",
    "LocalSend.LocalSend",

    # M
    "Mozilla.Firefox",
    "Microsoft.PowerToys",

    # N

    # O
    "OpenJS.NodeJS",
    "Oracle.VirtualBox",
    "Obsidian.Obsidian",

    # P
    # Q

    # R
    "RamenSoftware.Windhawk",
    "RevoUninstaller.RevoUninstaller",
    "RiotGames.Valorant.EU",
    "RustDesk.RustDesk",
    "REALiX.HWiNFO",

    # S
    "Safing.Portmaster",
    "Spotify.Spotify",

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
    'Docker Desktop',
    'FanControl',
    'Medal',
    'Samsung Magician',
    'Syncthing',
    'VirtualBox Extension Pack'
    'Office 365'
)

$installedPackages = winget list | ForEach-Object { $_.ToString() }

foreach ($pkg in $packages) {
    Write-Host "`n> installing package: $pkg" -ForegroundColor Cyan

    # Check if package is already installed via winget
    $isInstalled = $installedPackages -match $pkg
    if ($isInstalled) {
        Write-Host "> $pkg already installed; skipping to the next package." -ForegroundColor Red
    } else {
        winget install --id $pkg --silent --accept-source-agreements --accept-package-agreements
    }
}

# Display a list of applications which have to be installed manually
Write-Host "`n> manual install: $($manual_packages -join ', ')" -ForegroundColor Green

Pause