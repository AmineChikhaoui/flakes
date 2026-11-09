{ pkgs }:
{
  starpls = {
    command = "${pkgs.starpls}/bin/starpls";
    args = [ "server" ];
    filetypes = [ "bzl" "starlark" ];
    rootPatterns = [ "MODULE.bazel" "WORKSPACE.bazel" "WORKSPACE" ".bazelversion" ".git" ];
    requireRootPattern = true;
  };

  gopls = {
    command = "${pkgs.gopls}/bin/gopls";
    filetypes = [ "go" "gomod" "gowork" "gotmpl" ];
    rootPatterns = [ "go.work" "go.mod" ".git" ];
  };

  pylsp = {
    command = "${pkgs.python3Packages.python-lsp-server}/bin/pylsp";
    filetypes = [ "python" ];
    rootPatterns = [ "pyproject.toml" "setup.py" "setup.cfg" ".git" ];
  };

  zls = {
    command = "${pkgs.zls}/bin/zls";
    filetypes = [ "zig" "zir" ];
    rootPatterns = [ "build.zig" "build.zig.zon" ".git" ];
  };

  dhall = {
    command = "${pkgs.dhall-lsp-server}/bin/dhall-lsp-server";
    filetypes = [ "dhall" ];
    rootPatterns = [ "package.dhall" "dhall.dhall" ".git" ];
  };

  terraform = {
    command = "${pkgs.terraform-ls}/bin/terraform-ls";
    args = [ "serve" ];
    filetypes = [ "terraform" "terraform-vars" ];
    rootPatterns = [ ".terraform" ".terraform.lock.hcl" ".git" ];
  };

  typescript = {
    command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
    args = [ "--stdio" ];
    filetypes = [ "javascript" "javascriptreact" "typescript" "typescriptreact" ];
    rootPatterns = [ "tsconfig.json" "jsconfig.json" "package.json" ".git" ];
  };
}
