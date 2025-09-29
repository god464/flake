{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.network'.sparkle;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.network'.sparkle.enable = mkEnableOption "sparkle";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.sparkle ];
    security.wrappers.sparkle = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_bind_service,cap_net_raw,cap_net_admin=+ep";
      source = "${lib.getExe pkgs.sparkle}";
    };
    networking.firewall.trustedInterfaces = [ "mihomo" ];
  };
}
