{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          yaml-language-server
          nixfmt-rfc-style
          yamlfmt
          statix
          deadnix
          yamllint
          actionlint
          config.treefmt.build.wrapper
          just
        ];
        shellHook = config.pre-commit.installationScript;
      };
    };
}
