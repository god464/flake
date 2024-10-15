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
            "ata_piix"
            "mptspi"
            "uhci_hcd"
            "ehci_pci"
            "ahci"
            "sd_mod"
            "sr_mod"
          ];
          supportedFilesystems = [
            "btrfs"
            "tmpfs"
          ];
          systemd.enable = true;
        };
        kernelModules = [ "kvm-amd" ];
        kernelPackages = cfg.kernel;
        loader.efi.canTouchEfiVariables = true;
      }
      (mkIf display.enable {
        loader.grub = {
          enable = true;
          efiSupport = true;
          useOSProber = true;
          device = "nodev";
        };
        plymouth.enable = true;
        consoleLogLevel = 0;
        kernelParams = [
          "quiet"
          "splash"
        ];
      })
      (mkIf (!display.enable) {
        loader.systemd-boot = {
          enable = true;
          consoleMode = "max";
          editor = false;
        };
      })
    ];
  };
}
