{ pkgs, shared }:

shared.mkShell {
  packages = with pkgs; [
    gcc
    gdb
    clang
    clang-tools
    cmake
    ninja
    pkg-config
    gnumake
  ];
}
