{ pkgs, shared }:

shared.mkShell {
  packages = with pkgs; [
    nodejs
    bun
  ];
}
