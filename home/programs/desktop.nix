{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    alacritty
  ];

  programs.alacritty.enable = true;
  programs.firefox.enable = true;
}
