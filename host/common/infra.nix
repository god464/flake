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
