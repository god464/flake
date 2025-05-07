{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nil
          yaml-language-server
          nixfmt-rfc-style
          nodePackages_latest.prettier
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
