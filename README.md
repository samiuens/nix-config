# ⚙️ samiuen's machine configuration

This repository contains the nix configuration, to automate the setup of my local machines.

## 🤖 Inventory

|  hostname   |         system          |         cpu         |  ram  |         gpu          | role  |  os   | status |
| :---------: | :---------------------: | :-----------------: | :---: | :------------------: | :---: | :---: | :----: |
| `smi-nixos` | [Prime B550M-A (Wi-Fi)] | [AMD Ryzen 7 2700X] | 32GB  | [XFX Radeon RX 6600] |   🖥️   |   ❄️   |   ✅    |

## 📘 Overview
My personal machines run either [NixOS] or macOS in combination with [nix-darwin], managed and maintained using this nix configuration.

## 💫 Highlights

- ❄️ Nix flakes handles dependencies and packages
- 🏠 [home-manager] manages dotfiles
- 🍎 [nix-darwin] for mac configuration
- 🤫 [sops-nix] for encrypted secret management
- ⚡️ `justfile` contains useful aliases for many frequent and complicated commands
- ♻️ Automatic trash collection managed through `nix-gc`
- 🔑 Full Disk Encryption ([LUKS]) with Secure Boot
- 💼 Strict seperation of personal and work user profile
- 🖼️ Configuration of the desired desktop environment on [NixOS]

## 🧑‍💻 Getting Started

> [!NOTE]
> The script needs to be run as sudo or the user needs sudo permissions.

```console
cd ~
git clone https://github.com/samiuens/nix-config.git && cd nix-config
chmod +x install.sh && ./install.sh
```

### macOS

- On macOS, the script will install `nix` using the [Determinate Nix Installer].
- After running the script, you have to manually run the `nix-darwin` installer with the hostname, corresponding to the config, you want to apply.
- Also some settings are not covered by the nix configuration as they aren't available. (See docs).

### NixOS

- On NixOS, no extra steps are needed, as the `nix` package manager is already installed.
- Just run the installation script. If will setup up the folder structure, apply the nix configuration and optionally generate a keypair to support secure boot.
- Restart the machine and you're ready to go!

## 🚀 Post Installation
_[...]_

## 🖥️ Desktop Enviroments
My configuration offers the following desktop enviroments, which you can choose in the `configuration.nix` file.
1. [Gnome] – Simple & open-source desktop enviroment
2. *[Hyprland] – Tiling window manager (Planning...)*

## 📁 Repository

### 🧭 Structure

```markdown
.
├── hosts/
├── modules/
├── pkgs/
├── configuration.nix
├── flake.lock
├── flake.nix
├── install.sh
├── justfile
├── LICENSE
└── README.md
```

### 📃 License

This project is licensed under the terms of the [MIT license](https://github.com/samiuens/nix-config/blob/master/LICENSE).

## 📝 Documentation

_[...]_

[Prime B550M-A (Wi-Fi)]: https://www.asus.com/us/motherboards-components/motherboards/prime/prime-b550m-a-wi-fi/
[AMD Ryzen 7 2700X]: https://www.amd.com/en/support/downloads/drivers.html/processors/ryzen/ryzen-2000-series/amd-ryzen-7-2700x.html
[XFX Radeon RX 6600]: https://www.xfxforce.com/shop/xfx-speedster-swft-210-amd-radeon-tm-rx-6600-core
[NixOS]: https://nixos.org
[home-manager]: https://github.com/nix-community/home-manager
[nix-darwin]: https://github.com/nix-darwin/nix-darwin/tree/master
[sops-nix]: https://github.com/Mic92/sops-nix
[LUKS]: https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup
[Gnome]: https://gnome.org
[Hyprland]: https://hypr.land
[Determinate Nix Installer]: https://github.com/DeterminateSystems/nix-installer