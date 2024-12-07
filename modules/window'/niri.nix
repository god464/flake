{
  config,
  lib,
  pkgs,
  inputs,
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
    environment.systemPackages = with pkgs; [ wl-clipboard ];

    home-manager.users.cl = {
      imports = [ inputs.niri.homeModules.niri ];
      programs.niri = {
        enable = true;
      };
    };
    environment.persistence."/persist" = {
      users.cl = {
        directories = [
          ".config/dconf"
          ".local/share/keyrings"
        ];
      };
    };
  };
}
