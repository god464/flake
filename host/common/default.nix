{
  imports = [ ./i18n.nix ];
  booter.enable = true;
  users.mutableUsers = false;
  net.enable = true;
  zramSwap.enable = true;
  services = {
    btrfs.autoScrub.enable = true;
    openssh = {
      settings.PermitRootLogin = "no";
      openFirewall = false;
    };
  };
  sec.enable = true;
  nixp.enable = true;
}
