{ inputs, config, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  home-manager.users.cl = {
    home.stateVersion = config.system.stateVersion;

    xdg.enable = true;
  };
}
