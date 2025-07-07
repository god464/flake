{ config, lib, ... }:
let
  inherit (lib) mkIf;
  name = config.networking.hostName;

in
{
  config = mkIf (name != "livecd") {
    system = {
      tools.nixos-generate-config.enable = false;
      # forbiddenDependenciesRegexes = [ "perl" ];
    };
    environment.defaultPackages = [ ];
    documentation = {
      info.enable = false;
      nixos.enable = false;
    };
  };
}
