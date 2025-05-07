{ inputs, ... }:
{
  imports = [ inputs.git-hooks-nix.flakeModule ];
  perSystem.pre-commit.settings.hooks = {
    commitizen.enable = true;
    actionlint.enable = true;
    treefmt.enable = true;
    deadnix.enable = true;
  };
}
