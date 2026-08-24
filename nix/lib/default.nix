{ pkgs }:

rec {
  basePackages = with pkgs; [
    tree
    bat
    eza
  ];

  mkShell =
    {
      packages ? [ ],
      ...
    }@args:
    pkgs.mkShell (
      args
      // {
        packages = basePackages ++ packages;
      }
    );
}
