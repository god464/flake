{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.services'.minecraft;
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  options.services'.minecraft.enable = mkEnableOption "minecraft";
  config = mkIf cfg.enable {
    services.minecraft-servers = {
      enable = true;
      openFirewall = true;
      eula = true;
      servers.neoforge = {
        enable = true;
        package = pkgs.neoforgeServers.neoForge-1_20_1;
        serverProperties = {
          player-idle-timeout = 60;
          online-mode = false;
          motd = "巧克力与香子兰";
        };
        symlinks.mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            Mekanism.url = "https://cdn.modrinth.com/data/Ce6I4WUE/versions/uxe1WQp4/Mekanism-1.20.1-10.4.16.80.jar";
          }
        );
      };
    };
  };
}
