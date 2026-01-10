{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
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
          vulnix
        ];
        shellHook = config.pre-commit.installationScript;
      };
    };
}
