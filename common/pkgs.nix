{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    # Languages & runtimes
    pkgs.go
    pkgs.rustup
    pkgs.zig
    pkgs.dhall
    pkgs.dhall-json
    pkgs.yarn
    pkgs.uv
    pkgs.poetry
    (pkgs.python3.withPackages (ps: [ ps.black ]))

    # Cloud & infrastructure
    pkgs.terraform
    pkgs.terraform-docs
    pkgs.tflint
    pkgs.kubernetes-helm
    pkgs.azure-cli
    pkgs.awscli2
    pkgs.vault
    pkgs.json2hcl
    pkgs.jinja2-cli

    # Containers & virtualization
    pkgs.podman
    pkgs.dive
    pkgs.cosign
    pkgs.syft
    pkgs.grype
    pkgs.ko
    pkgs.qemu

    # Go tooling
    pkgs.golangci-lint
    pkgs.go-tools
    pkgs.goreleaser

    # Git & version control
    pkgs.git
    pkgs.github-cli
    pkgs.glab
    pkgs.lazygit
    pkgs.git-sizer

    # Shell & CLI utilities
    pkgs.bash
    pkgs.openssh
    pkgs.direnv
    pkgs.fzf
    pkgs.ripgrep
    pkgs.fd
    pkgs.bat
    pkgs.eza
    pkgs.tree
    pkgs.jq
    pkgs.yq
    pkgs.htop
    pkgs.gnused
    pkgs.just

    # Networking & security
    pkgs.mtr
    pkgs.nmap
    pkgs.gnupg
    pkgs.yubikey-manager
    pkgs.sops

    # Data
    pkgs.sqlite-interactive
    pkgs.xan

    # Linting & formatting
    pkgs.shellcheck
    pkgs.nixpkgs-fmt

    # Build tools
    pkgs.cmake

    # Media
    pkgs.ffmpeg
    pkgs.asciinema

    # Backup
    pkgs.backblaze-b2

    # Desktop apps
    pkgs.vscode
    pkgs.obsidian
    pkgs.helix
    pkgs.dbeaver-bin
    pkgs.nerd-fonts.fira-code

    # AI
    pkgs.codex
  ];
}
