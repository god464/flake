{
  config,
  lib,
  inputs,
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
      };
    };
  };
}
