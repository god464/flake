{
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.nix'.home-manager;
  inherit (lib) mkIf mkEnableOption;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  options.nix'.home-manager.enable = mkEnableOption "home-manager";
  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.cl.home.stateVersion = "24.11";
    };
  };
}
