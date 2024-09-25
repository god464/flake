{ inputs, ... }: {
  imports = with inputs; [ treefmt-nix.flakeModule git-hooks-nix.flakeModule ];
  perSystem = { config, pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [ nixd yaml-language-server nixfmt yamlfmt ];
      shellHook = config.pre-commit.installationScript;
    };
    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixfmt.enable = true;
    };
    pre-commit.settings.hooks = {
      commitizen.enable = true;
      treefmt.enable = true;
      deadnix.enable = true;
      statix.enable = true;
    };
  };
}
