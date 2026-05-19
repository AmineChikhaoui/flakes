{ pkgs }:
let
  custom = {
    vim-sentinel = pkgs.vimUtils.buildVimPlugin {
      name = "sentinel.vim";
      src = pkgs.fetchFromGitHub {
        owner = "hashicorp";
        repo = "sentinel.vim";
        rev = "670cf5628de46987be73c9f6d6b0fe15cea4c1f2";
        sha256 = "sha256-Jw02d2wErXtMWeuwN+kv6cjeW7qG8v/sKZAo8MWmcAU=";
      };
    };
    vim-ripgrep = pkgs.vimUtils.buildVimPlugin {
      name = "vim-ripgrep";
      src = pkgs.fetchFromGitHub {
        owner = "jremmen";
        repo = "vim-ripgrep";
        rev = "ec87af6b69387abb3c4449ce8c4040d2d00d745e";
        sha256 = "1by56rflr0bmnjvcvaa9r228zyrmxwfkzkclxvdfscm7l7n7jnmh";
      };
      patches = [
        (pkgs.fetchurl {
          url = "https://patch-diff.githubusercontent.com/raw/jremmen/vim-ripgrep/pull/64.patch";
          sha256 = "sha256-YAmY2DVcUbWPeLI0O3dxevFD1+0VFezsax1SgSBhZMA=";
        })
      ];
    };
    vim-autopep8 = pkgs.vimUtils.buildVimPlugin {
      name = "vim-autopep8";
      src = pkgs.fetchFromGitHub {
        owner = "tell-k";
        repo = "vim-autopep8";
        rev = "4191261db378fcad4213fc59a7f3be0c2735d543";
        sha256 = "154vnx034mccbda07zfqqmh99vbbkkqgizasl1gkbxsd8j4jx5vv";
      };
    };
    vim-deus = pkgs.vimUtils.buildVimPlugin {
      name = "vim-deus";
      src = pkgs.fetchFromGitHub {
        owner = "ajmwagar";
        repo = "vim-deus";
        rev = "2f88c926629ab094e8d7ec4942518075e7f47f96";
        sha256 = "sha256:1vmvs0rn4a1d9zi62pp9lfd682dagy31zdzsi36fyrr04510q8bb";
      };
    };
    badwolf = pkgs.vimUtils.buildVimPlugin {
      name = "badwolf";
      src = pkgs.fetchFromGitHub {
        owner = "sjl";
        repo = "badwolf";
        rev = "73e3198860d1e874874844688b83b6d7b35d644f";
        sha256 = "sha256:09h8p193c4mjmfqh08hmffpgdgqm5nx04mnmbcxm3w2cw05gv3jg";
      };
    };
  };

  standard = [
    "vim-nix"
    "vim-fugitive"
    "nerdtree"
    "vim-grammarous"
    "fzf-wrapper"
    "vim-airline"
    "vim-lawrencium"
    "vim-autoformat"
    "vim-docbk"
    "vim-docbk-snippets"
    "syntastic"
    "vim-codefmt"
    "molokai"
    "vim-cpp-enhanced-highlight"
    "vim-gitgutter"
    "dhall-vim"
    "coc-nvim"
    "vim-devicons"
    "vim-racer"
    "vim-go"
    "vim-ledger"
    "zig-vim"
    "vim-toml"
    "vim-terraform"
    "vim-terraform-completion"
    "vim-jsonnet"
    "salt-vim"
    "jq-vim"
    "vim-nickel"
  ];

  customNames = builtins.attrNames custom;
in
{ inherit custom standard customNames; }
