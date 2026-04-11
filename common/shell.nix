{ pkgs, ... }: {
  home.username = "amine.chikhaoui";
  home.homeDirectory = "/Users/amine.chikhaoui";
  home.stateVersion = "22.11";

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

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
      source $HOME/.atuin/bin/env
      export TERM=xterm-256color
      eval "$(${pkgs.starship}/bin/starship init bash)"
      source ~/.config/op/plugins.sh
    '';
    initExtra = ''
      source "${pkgs.bash-preexec}/share/bash/bash-preexec.sh"
      eval "$(atuin init bash)"
    '';
  };
}
