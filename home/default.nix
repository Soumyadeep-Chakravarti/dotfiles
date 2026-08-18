{ ... }:

{
  home.username = "sammy";
  home.homeDirectory = "/home/sammy";

  home.stateVersion = "26.05";

  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/packages.nix
    ./programs/desktop.nix
  ];

  programs.home-manager.enable = true;
}
