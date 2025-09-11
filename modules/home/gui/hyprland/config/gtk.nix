{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    font = {
      name = "Inter";
      package = null;
      size = 11;
    };
  };
}
