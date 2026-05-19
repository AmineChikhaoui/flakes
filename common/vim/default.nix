{ pkgs, lib, ... }:
let
  plugins = import ./plugins.nix { inherit pkgs; };
  commonRc = import ./rc.nix { inherit pkgs; };

  allPlugins =
    (lib.attrValues plugins.custom)
    ++ [ pkgs.vimPlugins.LanguageClient-neovim ]
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
    plugins = allPlugins
      ++ [ pkgs.vimPlugins.nvim-cmp pkgs.vimPlugins.telescope-nvim ];
    extraConfig = commonRc;
  };
}
