{ pkgs, shared }:

shared.mkShell {
  packages = with pkgs; [
    go
    gopls
  ];
}
