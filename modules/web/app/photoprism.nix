{ config, lib, ... }:
let
  cfg = config.web'.app.photoprism;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.photoprism.enable = mkEnableOption "photoprism";
  config = mkIf cfg.enable {
    services.photoprism = {
      enable = true;
      passwordFile = config.sops.secrets.passwd.path;
    };
  };
}
