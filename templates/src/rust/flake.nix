{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.rust-overlay.overlays.default ];
          };
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              config.treefmt.build.wrapper
              # Nix
              nixd
              nixfmt-rfc-style
              statix
              deadnix
              # TOML
              taplo
              # Rust
              (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
              vscode-extensions.vadimcn.vscode-lldb
              cargo-edit
            ];
            env.RUST_SRC_PATH = "${pkgs.rustToolchain}/lib/rustlib/src/rust/library";
            shellHook = ''
              export PATH=$PATH:${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter
              ${config.pre-commit.installationScript}

              if [ !-f "Cargo.toml" ]; then
              	  cargo init
              fi
            '';
          };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              rustfmt = {
                enable = true;
                edition = "2024";
              };
              taplo.enable = true;
            };
          };
          pre-commit.settings.hooks = {
            commitizen.enable = true;
            treefmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            clippy = {
              enable = true;
              settings.allFeatures = true;
            };
            taplo.enable = true;
            cargo-check.enable = true;
          };
        };
    };
}
