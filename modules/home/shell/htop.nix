{ config, lib, ... }:
let
  cfg = config.programs.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable { programs.htop.enable = true; };
}
