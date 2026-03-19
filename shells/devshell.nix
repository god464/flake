{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          config.treefmt.build.wrapper
          nixd
          yaml-language-server
          vscode-langservers-extracted
          nixfmt
          statix
          deadnix
          yamllint
          actionlint
          oxfmt
          just
        ];
        shellHook = config.pre-commit.installationScript;
      };
    };
}
