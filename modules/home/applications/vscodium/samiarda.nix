{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles =
      let
        sharedExtensions = pkgs.nix4vscode.forVscode [
          "pkief.material-icon-theme"
          "eamodio.gitlens"
          "seatonjiang.gitmoji-vscode"
        ];
        sharedUserSettings = {
          # Files
          "files.autoSave" = "afterDelay";

          # Appearance
          "window.commandCenter" = true;
          "workbench.iconTheme" = "material-icon-theme";

          # Editor
          "editor.fontSize" = 18;
          "editor.lineHeight" = 1.5;
          "editor.fontFamily" = "'JetBrains Mono'";
          "editor.cursorStyle" = "line-thin";
          "editor.smoothScrolling" = true;
          "editor.formatOnSave" = true;

          # Cursor
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.cursorBlinking" = "smooth";

          # Misc
          "workbench.list.smoothScrolling" = true;
          "terminal.integrated.smoothScrolling" = true;

          # Terminal
          "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
        };
      in
      {
        default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          extensions = sharedExtensions;
          userSettings = sharedUserSettings;
        };
        kid = {
          extensions =
            pkgs.nix4vscode.forVscode [
              "dbaeumer.vscode-eslint"
              "esbenp.prettier-vscode"
              "vue.volar"
              "nuxtr.nuxtr-vscode"
              "nuxt.mdc"
              "bradlc.vscode-tailwindcss"
            ]
            ++ sharedExtensions;
          userSettings = sharedUserSettings // {
            # Editor
            "editor.gotoLocation.multipleDefinitions" = "goto";

            # Linting
            "eslint.format.enable" = true;
          };
        };
      };
  };
}
