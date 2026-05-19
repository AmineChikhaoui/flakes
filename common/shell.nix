{ pkgs, ... }: {
  home.username = "amine";
  home.homeDirectory = "/Users/amine";
  home.stateVersion = "22.11";

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  programs.atuin.enable = true;

  home.shellAliases = {
    "ll" = "ls -l";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.nix-profile/bin/"
    "$HOME/Library/Python/3.9/bin/"
    "$HOME/.fly/bin"
  ];

  programs.direnv.enable = true;
  programs.starship.enable = true;
  programs.dircolors.enable = true;

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export TERM=xterm-256color
    '';
  };
}
