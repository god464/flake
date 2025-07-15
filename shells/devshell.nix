{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          config.treefmt.build.wrapper
          nixd
          nil
          yaml-language-server
          vscode-langservers-extracted
          nixfmt-rfc-style
          statix
          deadnix
          yamllint
          actionlint
          dprint
          just
          vulnix
        ];
        shellHook = config.pre-commit.installationScript;
      };
    };
}
