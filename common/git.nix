{ pkgs, lib, ... }:
let
  gitFzf = pkgs.writeScriptBin "git-fzf" ''
    #! /usr/bin/env bash
    git show --stat=120 --format="" | grep -E '^\s*\S+.*\|' | \
    fzf --ansi \
        --disabled \
        --bind 'j:down,k:up,q:abort' \
        --preview="echo {} | sed 's/|.*//' | xargs -I% git show --color=always $commit -- %" \
        --preview-window=right:60%"
  '';
in
{
  home.packages = [ gitFzf ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    extraConfig = ''
      SetEnv TERM=xterm-256color
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };

  programs.hunk = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Amine Chikhaoui";
      user.email = lib.mkDefault "amine@chikhaoui.org";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpjCPdRZTfFAO+XUpSpAf/ni8EQSAcllzyY1BDXl00V";
      gpg.format = "ssh";
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      commit.gpgsign = true;
      tag.gpgsign = true;
      alias = {
        pushall = "!git remote | xargs -L1 git push --all";
        graph = "log --decorate --oneline --graph";
        add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
      };
      feature.manyFiles = true;
      init.defaultBranch = "main";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
