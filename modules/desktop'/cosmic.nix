{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop'.cosmic;
  inherit (lib) mkEnableOption mkIf mkAfter;
in
{
  imports = [ inputs.nixos-cosmic.nixosModules.default ];
  options.desktop'.cosmic = {
    enable = mkEnableOption "cosmic";
  };
  config = mkIf cfg.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    environment = {
      systemPackages = mkAfter [ pkgs.wl-clipboard ];
      persistence."/persist".users.cl.directories = [
        ".local/state/cosmic-comp"
        ".local/state/cosmic"
        ".local/state/pop-launcher"
        ".config/cosmic"
      ];
    };
  };
}
