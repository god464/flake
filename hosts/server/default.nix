{ config, ... }:
{
  imports = [ ./disk.nix ];
  boot'.boot.availableKernelModules = [
    "ata_piix"
    "mptspi"
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "sd_mod"
    "sr_mod"
  ];
  network'.net.name = "server";
  hardware.facter.reportPath = ./facter.json;
  services'.ssh = {
    enable = true;
    hostKey = "/var/ssh/ssh_host_ed25519_key";
  };
  sops = {
    age.sshKeyPaths = [ "/var/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  users.users.root = {
    hashedPasswordFile = config.sops.secrets.passwd.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPoVNcyt4lHWmTaR5SOlRe3FLNGGbtHD3IsQOSl8E426"
    ];
  };
  environment.etc."machine-id" = {
    text = "c2e991aba7c2429cb92b63177e1e1170";
    mode = "0444";
  };
  programs.nh.enable = false;
  web'.search.meilisearch.enable = true;
}
