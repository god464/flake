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
        hostname = "nekopara";
        image = "itzg/minecraft-server:java17";
        ports = [ "127.0.0.1:25565:25565" ];
        volumes = [ "/var/lib/mc:/data" ];
        environment = {
          EULA = "TRUE";
          TYPE = "FORGE";
          VERSION = "1.20.1";
          MODRINTH_DOWNLOAD_DEPENDENCIES = "required";
          MODRINTH_PROJECTS = ''
            "Ce6I4WUE"
            "XxWD5pD3"
            "OFVYKsAk"
            "tqQpq1lt"
            "a6F3uASn"
          '';
        };
      };
    };
  };
}
