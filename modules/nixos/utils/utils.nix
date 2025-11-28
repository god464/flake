{ config, lib, ... }:
let
  inherit (lib) mkIf;
  name = config.networking.hostName;
in
{
  config = mkIf (name != "livecd") {
    system = {
      tools.nixos-generate-config.enable = false;
      stateVersion = "25.11";
      # forbiddenDependenciesRegexes = [ "perl" ];
    };
    systemd.oomd.enable = true;
    environment.defaultPackages = [ ];
    documentation = {
      info.enable = false;
      nixos.enable = false;
    };
  };
}
