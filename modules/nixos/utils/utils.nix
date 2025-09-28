{ config, lib, ... }:
let
  inherit (lib) mkIf;
  name = config.networking.hostName;
in
{
  config = mkIf (name != "livecd") {
    system = {
      tools.nixos-generate-config.enable = false;
      stateVersion = "25.05";
      # forbiddenDependenciesRegexes = [ "perl" ];
    };
    systemd.oomd.enable = true;
    environment.defaultPackages = [ ];
    environment.sessionVariables = {
      GOPROXY = "https://goproxy.io,direct";
    };
    documentation = {
      info.enable = false;
      nixos.enable = false;
    };
  };
}
