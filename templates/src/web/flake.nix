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
              # HTML
              vscode-langservers-extracted
              superhtml
              htmlhint
              nodePackages.prettier
              # CSS
              tailwindcss-language-server
              stylelint
              # JavaScript / TypeScript
              bun
              typescript
              vtsls
              eslint
              nodejs-slim_latest
              # vue-language-server # Vue
              # astro-language-server # Astro
            ];
            shellHook = config.pre-commit.installationScript;
          };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              prettier.enable = true;
            };
          };
          pre-commit.settings.hooks = {
            statix.enable = true;
            deadnix.enable = true;
            commitizen.enable = true;
            denolint.enable = true;
            treefmt.enable = true;
          };
        };
    };
}
