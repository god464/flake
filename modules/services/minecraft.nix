{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.services'.rustdesk;
in
{
  options.services'.minecraft.enable = mkEnableOption "minecraft";
  config = mkIf cfg.enable {
    services.minecraft-server = {
      enable = true;
      package = pkgs.papermc;
      openFirewall = true;
      eula = true;
    };
  };
}
