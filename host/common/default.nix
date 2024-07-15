{
  imports = [ ./i18n.nix ];
  booter.enable = true;
  users.mutableUsers = false;
  net.enable = true;
  zramSwap.enable = true;
  sops = {
    age = {
      keyFile = "/var/lib/key.txt";
      generateKey = true;
    };
    defaultSopsFile = ../../secrets/vm.yaml;
    secrets.passwd.neededForUsers = true;
  };
  services = {
    btrfs.autoScrub.enable = true;
    dbus.apparmor = "enabled";
    openssh = {
      settings.PermitRootLogin = "no";
      openFirewall = false;
    };
  };
  security = import ./security.nix;
  nixp.enable = true;
  system.stateVersion = "24.05";
}
