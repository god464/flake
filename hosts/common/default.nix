{
  imports = [ ./i18n.nix ];
  users.mutableUsers = false;
  hardware.cpu.amd.updateMicrocode = true;
  zramSwap.enable = true;
  services.btrfs.autoScrub.enable = true;
}
