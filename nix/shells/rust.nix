{ pkgs, shared }:

shared.mkShell {
  packages = with pkgs; [
    rustc
    cargo
    rust-analyzer
  ];
}
