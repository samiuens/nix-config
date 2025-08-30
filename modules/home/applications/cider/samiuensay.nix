{ pkgs, ... }:
let
  cider = pkgs.appimageTools.wrapType2 rec {
    pname = "Cider";
    version = "3.1.2";
    src = ./cider-v3.1.2-linux-x64.AppImage; # Download the cider application and place it in this directory

    extraInstallCommands =
      let
        contents = pkgs.appimageTools.extract { inherit pname version src; };
      in
      ''
        install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}'
        cp -r ${contents}/usr/share/icons $out/share
      '';
  };
in
{
  home.packages = [ cider ];
}
