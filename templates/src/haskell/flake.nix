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
            packages =
              with pkgs;
              [
                config.treefmt.build.wrapper
                # Nix
                nil
                nixd
                nixfmt-rfc-style
                statix
                deadnix
                # Haskell
                ghc
                haskell-language-server
                ormolu
                hlint
                stack
                # YAML
                dprint
                yaml-language-server
                yamllint
              ]
              ++ (with pkgs.haskellPackages; [
                fast-tags
                hoogle
                haskell-debug-adapter
              ]);
            shellHook = config.pre-commit.installationScript;
          };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              dprint.enable = true;
              ormolu.enable = true;
            };
          };
          pre-commit.settings.hooks = {
            commitizen.enable = true;
            treefmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            hlint.enable = true;
          };
        };
    };
}
