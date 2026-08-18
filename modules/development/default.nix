{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    ripgrep
    fd
    jq
    yq
    curl
    wget
    unzip
    zip
    gh
  ];
}
