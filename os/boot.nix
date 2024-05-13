{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules =
        [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
      supportedFilesystems = [ "btrfs" "ntfs" "exfat" ];
    };
    kernelModules = [ "kvm-amd" ];
  };
  zramSwap.enable = true;
}
