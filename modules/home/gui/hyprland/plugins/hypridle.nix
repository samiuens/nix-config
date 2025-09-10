{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [ "hypridle" ];
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "qs ipc call lock lock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 180; # 3 mins
          #on-timeout = "loginctl lock-session";
          on-timeout = "qs ipc call lock lock";
        }
        {
          timeout = 300; # 5 mins
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600; # 10 mins
          on-timeout = "systemctl suspend-then-hibernate || loginctl suspend";
        }
      ];
    };
  };
}
