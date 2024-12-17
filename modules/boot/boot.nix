{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkMerge
    types
    mkOption
    mkDefault
    ;
  display = config.services.displayManager;
  cfg = config.boot'.boot;
in
{
  options.boot'.boot = {
    kernel = mkOption {
      type = types.raw;
      default = pkgs.linuxPackages;
    };
    para = mkOption {
      default = [ ];
      type = types.listOf types.str;
    };
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
          systemd.enable = config.system.etc.overlay.enable;
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
        tmp.useTmpfs = true;
      }
      (
        if display.enable then
          {
            loader.systemd-boot.consoleMode = "0";
            plymouth.enable = true;
            consoleLogLevel = 0;
            kernelParams = cfg.para ++ [
              "quiet"
              "splash"
            ];
          }
        else
          {
            loader.systemd-boot.consoleMode = "max";
          }
      )
    ];
    zramSwap.enable = true;
    services.btrfs.autoScrub.enable = mkDefault true;
  };
}
