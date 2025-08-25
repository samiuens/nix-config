{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
      autocd = true;
      initContent = ''
        export GPG_TTY=$(tty)
      '';

      shellAliases = {
        config = "cd ~/nixos-config && just $1";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "docker"
        ];
      };
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./theme.json));
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      colors = "auto";
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
