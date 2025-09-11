{
  inputs,
  pkgs,
  hostConfig,
  ...
}:
let
  caelestia-qml-plugin = pkgs.stdenv.mkDerivation {
    name = "caelestia-qml-plugin";
    src = ../caelestia;

    nativeBuildInputs = with pkgs; [
      cmake
      ninja
      pkg-config
    ];

    buildInputs = with pkgs; [
      qt6.qtmultimedia
      aubio
    ];

    dontWrapQtApps = true;

    cmakeFlags = [
      "-DCMAKE_BUILD_TYPE=RelWithDebInfo"
      "-DENABLE_MODULES=plugin"
      "-DINSTALL_QMLDIR=${placeholder "out"}/lib/qt6/qml"
      "-DVERSION=1.0.0"
      "-DGIT_REVISION=local"
    ];

    meta = {
      description = "Caelestia QML Plugin";
    };
  };
in
{
  home.packages = with pkgs; [
    # Quickshell
    quickshell
    caelestia-qml-plugin
    #caelestia-shell
    inputs.caelestia-cli.packages.${pkgs.system}.default

    # UI
    qt6.qt5compat
    qt6.qtbase
    qt6.qtquick3d
    qt6.qtwayland
    qt6.qtdeclarative
    qt6.qtsvg
    /*
      glib
      adwaita-qt6
      adwaita-fonts
      adwaita-icon-theme
    */

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
    ".config/quickshell".source = ../caelestia;
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
