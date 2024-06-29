{ inputs, config, lib, ... }: {
  imports = [ ./i18n.nix ./nix.nix ];
  boot = import ./infra.nix;
  users.mutableUsers = false;
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
  };
  security = import ./security.nix;
  system.stateVersion = "24.05";
}
