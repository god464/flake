{
  imports = [ ./i18n.nix ];
  users.mutableUsers = false;
  zramSwap.enable = true;
  services = {
    btrfs.autoScrub.enable = true;
    openssh = {
      settings.PermitRootLogin = "no";
      openFirewall = false;
    };
  };
  sec.enable = true;
}
