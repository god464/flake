{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.boot'.persist;
in
{
  config = mkIf cfg.enable {
    services.snapper = {
      configs.persist = {
        SUBVOLUME = "/persist";
        FSTYPE = "btrfs";
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "2";
        TIMELINE_LIMIT_MONTHLY = "3";
        TIMELINE_LIMIT_YEARLY = "0";
      };
      persistentTimer = true;
    };
  };
}
