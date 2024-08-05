{ config, lib, ... }:
let
  inherit (lib) mkMerge mkIf;
in
{
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
          supportedFilesystems = [ "btrfs" ];
        };
        kernelModules = [ "kvm-amd" ];
        loader.efi.canTouchEfiVariables = true;
      }
      (mkIf
        (config.services.displayManager.sddm.enable || config.services.displayManager.cosmic-greeter.enable)
        {
          loader.grub = {
            enable = true;
            efiSupport = true;
            device = "nodev";
            gfxmodeEfi = "auto";
            gfxmodeBios = "auto";
            gfxpayloadEfi = "auto";
            gfxpayloadBios = "auto";
          };
          plymouth.enable = true;
          consoleLogLevel = 0;
          kernelParams = [ "quiet" ];
        }
      )
      (mkIf
        (
          !config.services.displayManager.sddm.enable && !config.services.displayManager.cosmic-greeter.enable
        )
        {
          loader.systemd-boot = {
            enable = true;
            consoleMode = "max";
            editor = false;
          };
        }
      )
    ];
  };
}
