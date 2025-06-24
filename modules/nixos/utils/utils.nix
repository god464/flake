{ config, lib, ... }:
let
  inherit (lib) mkIf;
  name = config.networking.hostName;
in

{
  config = mkIf (name != "livecd") {
    programs.command-not-found.enable = false;
    system = {
      tools.nixos-generate-config.enable = false;
      forbiddenDependenciesRegexes = [ "perl" ];
    };
    boot.enableContainers = false;
    environment.defaultPackages = [ ];
    documentation = {
      info.enable = false;
      nixos.enable = false;
    };
  };
}
