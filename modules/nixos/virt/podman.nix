{ config, lib, ... }:
let
  cfg = config.virtual'.podman;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.virtual'.podman.enable = mkEnableOption "podman";
  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
