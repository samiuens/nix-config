{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles = {
      default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = pkgs.nix4vscode.forVscode [
          "pkief.material-icon-theme"
          "eamodio.gitlens"
          "seatonjiang.gitmoji-vscode"
          "yzhang.markdown-all-in-one"
          "jnoortheen.nix-ide"
        ];

        userSettings = {
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

          # Languages
          "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
          "[nix]"."editor.tabSize" = 2;
        };
      };
    };
  };
}
