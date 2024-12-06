{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.window'.niri;
in
{
  options.window'.niri.enable = mkEnableOption "niri";
  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [ wl-clipboard ];
    environment.persistence."/persist" = {
      users.cl = {
        directories = [
          ".config/dconf"
          ".local/share/keyrings"
          ".local/state/wireplumber"
        ];
      };
    };
  };
}
