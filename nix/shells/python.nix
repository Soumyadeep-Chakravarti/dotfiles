{ pkgs, shared }:

shared.mkShell {
  packages = with pkgs; [
    python3
    uv
  ];
}
