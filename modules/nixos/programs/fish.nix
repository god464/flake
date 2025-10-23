{ config, lib, ... }:
let
  cfg = config.programs'.fish;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.programs'.fish.enable = mkEnableOption "fish";
  config = mkIf cfg.enable {
    sops.secrets.google-code-id.owner = "cl";
    programs.fish = {
      enable = true;
      useBabelfish = true;
    };
  };
}
