{ inputs, ... }: {
  imports = [
    inputs.hunk.homeManagerModules.default
    ./pkgs.nix
    ./vim
    ./git.nix
    ./shell.nix
  ];
}
