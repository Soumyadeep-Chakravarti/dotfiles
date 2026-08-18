{ pkgs, ... }:

{
  users.users.sammy = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
