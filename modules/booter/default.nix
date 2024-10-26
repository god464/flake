{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkMerge
    mkIf
    types
    mkOption
    ;
  display = config.services.displayManager;
  cfg = config.booter;
in
{
  options.booter.kernel = mkOption {
    type = types.raw;
    default = pkgs.linuxPackages;
  };
  config = {
    boot = mkMerge [
      {
        initrd = {
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "uas"
            "usb_storage"
            "sd_mod"
          ];
          supportedFilesystems = [
            "btrfs"
            "tmpfs"
            "ntfs"
          ];
        };
        kernelModules = [ "kvm-amd" ];
        kernelPackages = cfg.kernel;
        loader = {
          efi.canTouchEfiVariables = true;
          systemd-boot = {
            enable = true;
            editor = false;
          };
        };
      }
      (mkIf display.enable {
        loader.systemd-boot.enable = lib.mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
        loader.systemd-boot.consoleMode = "0";
        plymouth.enable = true;
        consoleLogLevel = 0;
        tmp.useTmpfs = true;
        kernelParams = [
          "quiet"
          "splash"
        ];

      })
      (mkIf (!display.enable) {
        loader.systemd-boot.consoleMode = "max";
      })
    ];
  };
}
