{ config, lib, ... }:
let
  inherit (lib) mkIf;
  name = config.networking.hostName;
in
{
  config = mkIf (name != "livecd") {
    programs.nano.enable = false;
    system = {
      tools.nixos-generate-config.enable = false;
      stateVersion = "26.05";
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
