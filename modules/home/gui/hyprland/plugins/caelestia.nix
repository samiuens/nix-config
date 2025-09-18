{
  inputs,
  pkgs,
  hostConfig,
  ...
}:
let
  caelestia-qml-plugin = inputs.caelestia.packages.${pkgs.system}.default;
  caelestia-cli = inputs.caelestia.packages.${pkgs.system}.cli;
in
{
  home.packages = with pkgs; [
    caelestia-qml-plugin
    caelestia-cli

    # Quickshell
    quickshell

    # UI
    qt6.qt5compat
    qt6.qtbase
    qt6.qtquick3d
    qt6.qtwayland
    qt6.qtdeclarative
    qt6.qtsvg

    # Fonts
    noto-fonts

    # GUI Applications
    nautilus
    loupe
    gnome-calculator
    file-roller

    # Utils
    ddcutil
    brightnessctl
    wireplumber
    lm_sensors
    wl-clipboard
    trash-cli
    app2unit
  ];

  home.sessionVariables = {
    QML2_IMPORT_PATH = "${caelestia-qml-plugin}/lib/qt6/qml:$QML2_IMPORT_PATH";
  };

  home.file = {
    ".config/quickshell".source = inputs.caelestia;
  };

  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "QML2_IMPORT_PATH,${caelestia-qml-plugin}/lib/qt6/qml"
      ];
    };
    extraConfig = ''
      exec-once = qs -d
      source = ~/.config/hypr/scheme/current.conf
    '';
  };
}
