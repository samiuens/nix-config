{
  wayland.windowManager.hyprland.extraConfig = ''
    general {
      layout = "master"

      allow_tearing = false

      gaps_workspaces = 20
      gaps_in = 10
      gaps_out = 20
      border_size = 1

      col.active_border = rgb($primary)
      col.inactive_border = rgb($onSurface)
    }
  '';
}
