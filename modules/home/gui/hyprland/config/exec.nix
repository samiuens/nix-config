{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Clipboard Manager
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"

      # Empty trash after 30 days
      "trash-empty 30"
    ];
  };
}
