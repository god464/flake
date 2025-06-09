{
  inputs,
  lib,
  config,
  topcfg,
  ...
}:
let
  cfg = config.nix'.home-manager;
  inherit (lib) mkIf mkEnableOption;
in
{
  imports = with inputs; [ home-manager.nixosModules.home-manager ];
  options.nix'.home-manager.enable = mkEnableOption "home-manager";
  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [ topcfg.flake.homeModules.default ];
      users.cl.home.stateVersion = "25.05";
    };
  };
}
