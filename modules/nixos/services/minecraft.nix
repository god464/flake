{ config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.services'.minecraft;
in
{
  options.services'.minecraft.enable = mkEnableOption "minecraft";
  config = mkIf cfg.enable {
    virtualisation = {
      oci-containers.containers."minecraft" = {
        image = "itzg/minecraft-server:java17";
        ports = [ "127.0.0.1:25565:25565" ];
        volumes = [ "/data:/var/lib/mc" ];
      };
    };
  };
}
