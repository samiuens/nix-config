{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [ aerospace ];
    file."${config.xdg.configHome}/aerospace/aerospace.toml" = {
      source = ./aerospace.toml;
    };
  };
}
