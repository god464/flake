{ config, lib, ... }:
let
  inherit (lib) mkDefault mkIf mkMerge;
  name = config.networking.hostName;
in
{
  config = mkMerge [
    {
      system.etc.overlay = {
        enable = true;
        mutable = false;
      };
      system.nixos-init.enable = mkDefault true;
      environment.etc."nixos".text = "";
      programs.nix-ld.enable = true;
      services.envfs.enable = mkDefault true;
      security = {
        sudo.enable = false;
        sudo-rs = {
          enable = true;
          execWheelOnly = true;
          extraConfig = "Defaults !pwfeedback";
        };
      };
      users.mutableUsers = false;
      services.userborn.enable = config.system.etc.overlay.enable;
    }

    (mkIf (name != "livecd") {
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
    })
  ];
}
