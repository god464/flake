{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.network'.clash;
  inherit (lib) mkEnableOption mkIf mkAfter;
in
{
  options.network'.clash.enable = mkEnableOption "clash";
  config = mkIf cfg.enable {
    users.users.cl.packages = mkAfter [ pkgs.mihomo-party ];
    security.wrappers.mihomo-party = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_bind_service,cap_net_admin=+ep";
      source = "${lib.getExe pkgs.mihomo-party}";
    };
  };
}
