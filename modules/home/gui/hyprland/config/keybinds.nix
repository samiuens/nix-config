{
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        "$mod, T, exec, kitty"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );
    };
    extraConfig = ''
      # Launcher
      bind   = Super, Space, global, caelestia:launcher
      bindin = Super, mouse:272, global, caelestia:launcherInterrupt
      bindin = Super, mouse:273, global, caelestia:launcherInterrupt
      bindin = Super, mouse:274, global, caelestia:launcherInterrupt
      bindin = Super, mouse:275, global, caelestia:launcherInterrupt
      bindin = Super, mouse:276, global, caelestia:launcherInterrupt
      bindin = Super, mouse:277, global, caelestia:launcherInterrupt
      bindin = Super, mouse_up, global, caelestia:launcherInterrupt
      bindin = Super, mouse_down, global, caelestia:launcherInterrupt

      # Lock
      bind   = Super, L, global, caelestia:lock

      # Brightness
      bindl = , XF86MonBrightnessUp, global, caelestia:brightnessUp
      bindl = , XF86MonBrightnessDown, global, caelestia:brightnessDown

      # Media
      bindl = Ctrl+Super, Space, global, caelestia:mediaToggle
      bindl = , XF86AudioPlay, global, caelestia:mediaToggle
      bindl = , XF86AudioPause, global, caelestia:mediaToggle
      bindl = Ctrl+Super, Equal, global, caelestia:mediaNext
      bindl = , XF86AudioNext, global, caelestia:mediaNext
      bindl = Ctrl+Super, Minus, global, caelestia:mediaPrev
      bindl = , XF86AudioPrev, global, caelestia:mediaPrev
      bindl = , XF86AudioStop, global, caelestia:mediaStop
    '';
  };
}
