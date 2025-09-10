{
  inputs,
  pkgs,
  hostConfig,
  ...
}:
let
  /*
    caelestia-shell = pkgs.callPackage ../caelestia/nix {
      rev = "idk";
      stdenv = pkgs.clangStdenv;
      quickshell = inputs.quickshell.packages.${pkgs.system}.default.override {
        withX11 = false;
        withI3 = false;
      };
      app2unit = pkgs.callPackage ../caelestia/nix/app2unit.nix { inherit pkgs; };
      caelestia-cli = inputs.caelestia-cli.packages.${pkgs.system}.default;
    };
  */

  # Separates QML Plugin für lokale Entwicklung
  caelestia-qml-plugin = pkgs.stdenv.mkDerivation {
    name = "caelestia-qml-plugin-local";
    src = ../caelestia;

    nativeBuildInputs = with pkgs; [
      cmake
      ninja
      pkg-config
    ];

    buildInputs = with pkgs; [
      qt6.qtbase
      qt6.qtdeclarative
      qt6.qtmultimedia
      libqalculate
      aubio
    ];

    # Deaktiviere Qt App Wrapping für Plugin/Library
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
    quickshell
    caelestia-qml-plugin
    ddcutil
    brightnessctl
    wireplumber
    lm_sensors
    wl-clipboard
    trash-cli
    app2unit
    #caelestia-shell
    inputs.caelestia-cli.packages.${pkgs.system}.default
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
