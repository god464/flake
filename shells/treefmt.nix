{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    just.enable = true;
    oxfmt.enable = true;
  };
}
