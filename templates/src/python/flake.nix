{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = with inputs; [
        treefmt-nix.flakeModule
        git-hooks-nix.flakeModule
      ];
      systems = [ "x86_64-linux" ];
      perSystem =
        { config, pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              config.treefmt.build.wrapper
              # Nix
              nil
              nixd
              nixfmt-rfc-style
              statix
              deadnix
              # python
              python3
              uv
              basedpyright
              ruff
              ty
              python3Packages.debugpy
              python3Packages.venvShellHook
              # TOML
              taplo
            ];
            shellHook = ''
              ${config.pre-commit.installationScript}

              if [ ! -f "pyproject.toml" ]; then
                  uv init
              fi
            '';
          };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              ruff-format.enable = true;
              taplo.enable = true;
            };
          };
          pre-commit.settings.hooks = {
            commitizen.enable = true;
            treefmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            ruff.enable = true;
            taplo.enable = true;
          };
        };
    };
}
