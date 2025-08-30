{ pkgs, ... }:
let
  ciderAppImagePath = builtins.getEnv "CIDER_APPIMAGE";

  cider =
    if ciderAppImagePath != null && ciderAppImagePath != "" then
      pkgs.appimageTools.wrapType2 rec {
        pname = "Cider";
        version = "3.1.2";
        src = ciderAppImagePath;

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
      }
    else
      null;
in
{
  home.packages = pkgs.lib.optionals (cider != null) [ cider ];
}
