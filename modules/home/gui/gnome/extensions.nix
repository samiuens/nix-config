{ pkgs, hostConfig, ... }:
let
  gnomeExtensions = map (name: pkgs.gnomeExtensions.${name}) hostConfig.guis."gnome".extensions;
in
{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = map (ext: ext.extensionUuid) gnomeExtensions;
      };
      "org/gnome/shell/extensions/pano" = {
        exclusion-list = [
          "Bitwarden"
          "1Password"
          "KeePassXC"
        ];
        global-shortcut = [ "<Shift><Control>v" ];
        history-length = 50;
        play-audio-on-copy = false;
        send-notification-on-copy = false;
      };
    };
  };
}
