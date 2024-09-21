{
  users.mutableUsers = false;
  hardware.cpu.amd.updateMicrocode = true;
  zramSwap.enable = true;
  services.btrfs.autoScrub.enable = true;
  documentation = {
    enable = false;
    man.enable = false;
    nixos.enable = false;
    info.enable = false;
    doc.enable = false;
  };
}
