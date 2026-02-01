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
      servers.fabric = {
        enable = true;
        package = pkgs.fabricServers-1_21_1;
        serverProperties = {
          player-idle-timeout = 60;
          online-mode = false;
          motd = "巧克力与香子兰";
        };
      };
    };
  };
}
