{ lib, config, pkgs, ... }:
{
  imports = [
    ../../system/coreDesktop.nix
  ];
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = lib.mkForce false;
        netbootxyz.enable = true;
        memtest86.enable = true;
      };
    };
    programs = {
      hyprland = {
        enable = true;
        xwayland = {
          enable = true;
          hidpi = true;
        };
      };
    };
    services = {
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "tuigreet --cmd Hyprland";
          };
        };
      };
      mpd = {
        enable = true;
      };
    };
  }
