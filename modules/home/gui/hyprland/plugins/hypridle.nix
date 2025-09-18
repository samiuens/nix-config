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
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 180; # 3 mins
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          timeout = 600; # 10 mins
          on-timeout = "qs ipc call lock lock";
        }
        {
          timeout = 630; # 10.5 mins
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
          timeout = 900; # 15 mins
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
