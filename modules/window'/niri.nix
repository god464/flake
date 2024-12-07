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
    programs = {
      niri = {
        enable = true;
        package = pkgs.niri;
      };
      xwayland.enable = true;
    };
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
    environment.systemPackages = with pkgs; [ wl-clipboard ];

    home-manager.users.cl = {
      imports = [ inputs.niri.homeModules.niri ];
      programs.niri = {
        enable = true;
        settings = {
          input.keyboard.xkb.layout = "us";
          layout = {
            center-focused-column = "on-overflow";
            preset-column-widths = [
              { proportion = 1. / 3.; }
              { proportion = 1. / 2.; }
              { proportion = 2. / 3.; }
            ];
            default-column-width.proportion = 1. / 2.;
            focus-ring.enable = true;
          };
          binds = {
            "Mod+T".action.spawn = "wezterm";
          };
        };
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
