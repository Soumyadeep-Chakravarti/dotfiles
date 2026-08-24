# Shared Nix Development Infrastructure

This directory provides a small, versioned foundation for development shells.
It owns shared developer tools and shell construction; individual projects own
their language, framework, and service dependencies.

Use the reference shells from this repository when needed:

```sh
nix develop ~/dotfiles/nix#python
nix develop ~/dotfiles/nix#rust
nix develop ~/dotfiles/nix#quality
```

The `quality` shell provides the formatters and linters used by the repository
pre-commit hooks.

Project flakes should consume the shared helper and use the same `nixpkgs`
input. For a local dotfiles checkout, a Python project can start with:

```nix
{
  description = "Project development environment";

  inputs = {
    dotfiles-nix.url = "path:/home/sammy/dotfiles/nix";
    nixpkgs.follows = "dotfiles-nix/nixpkgs";
  };

  outputs = { self, nixpkgs, dotfiles-nix }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      shared = dotfiles-nix.lib.${system};
    in {
      devShells.${system}.default = shared.mkShell {
        packages = with pkgs; [
          python3
          uv
        ];
      };
    };
}
```

Replace the absolute path with a Git URL when a project must be reproducible
outside this workstation.
