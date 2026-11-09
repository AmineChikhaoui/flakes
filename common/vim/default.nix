{ pkgs, lib, ... }:
let
  plugins = import ./plugins.nix { inherit pkgs; };
  commonRc = import ./rc.nix { inherit pkgs; };

  allPlugins =
    (lib.attrValues plugins.custom)
    ++ (map (p: pkgs.vimPlugins.${p}) plugins.standard);

  vimConfigurable = pkgs.vim-full.customize {
    name = "vim";
    vimrcConfig = {
      customRC = commonRc;
      packages.myVimPackage = {
        start = allPlugins;
      };
    };
  };

  delveAll = pkgs.delve.overrideAttrs
    (old: {
      meta.platforms = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    });
in
{
  home.packages = [
    vimConfigurable
    pkgs.terraform-ls
    pkgs.gopls
    pkgs.starpls
    pkgs.zls
    pkgs.python3Packages.python-lsp-server
    pkgs.dhall-lsp-server
    pkgs.typescript-language-server
    delveAll
    pkgs.nodejs
  ];

  home.sessionVariables.EDITOR = "nvim";

  programs.bash.bashrcExtra = ''
    export EDITOR=nvim
  '';

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = true;
    withPython3 = true;
    plugins = allPlugins;
    extraConfig = commonRc;
  };
}
