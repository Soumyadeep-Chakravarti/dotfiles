{
  description = "Shared development infrastructure for Sammy's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system: f system);
    in {
      lib = forAllSystems (system:
        import ./lib { pkgs = import nixpkgs { inherit system; }; });

      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          shared = import ./lib { inherit pkgs; };
          mk = file: import file { inherit pkgs shared; };
        in {
          default = shared.mkShell { };
          systems = mk ./shells/systems.nix;
          rust = mk ./shells/rust.nix;
          python = mk ./shells/python.nix;
          web = mk ./shells/web.nix;
          go = mk ./shells/go.nix;
        });
    };
}
