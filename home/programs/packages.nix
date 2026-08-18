{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    eza
    fzf
    yq
    fastfetch
    btop
    pciutils
    usbutils
    zellij
  ];
}
