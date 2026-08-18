{ ... }:

{
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza -lah";
      la = "eza -a";
      l = "eza -I";
      cat = "bat";
    };
  };
}
