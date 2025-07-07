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
  options.boot'.boot.para = mkOption {
    default = [ ];
    type = types.listOf types.str;
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
          systemd.enable = true;
        };
        enableContainers = false;
        kernelModules = [ "kvm-amd" ];
        kernelPackages = pkgs.linuxPackages_latest;
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
            plymouth.enable = true;
            consoleLogLevel = 0;
            kernelParams = cfg.para ++ [
              "quiet"
              "splash"
            ];
          }
        else
          { }
      )
    ];
    zramSwap.enable = true;
    services.btrfs.autoScrub.enable = mkDefault true;
  };
}
