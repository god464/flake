{ inputs, ... }:
{
  imports = [ inputs.git-hooks-nix.flakeModule ];
  perSystem =
    { pkgs, ... }:
    {
      pre-commit.settings.hooks = {
        commitizen = {
          package = pkgs.commitizen.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [
              (pkgs.fetchpatch2 {
                name = "upgrade patch";
                url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/539725.patch?full_index=1";
                hash = "sha256-Ur950pJFyKcRpjbyLf5vYvvmD4VsZUDB9leRJ0BuUrM=";
              })
            ];
          });
          enable = true;
        };
        actionlint.enable = true;
        treefmt.enable = true;
        deadnix.enable = true;
        statix.enable = true;
      };
    };
}
