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
  services'.ssh.enable = true;
  sops = {
    age.sshKeyPaths = [ "/var/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  environment.etc."machine-id".text = "c2e991aba7c2429cb92b63177e1e1170";
}
