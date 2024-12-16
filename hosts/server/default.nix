{ config, ... }:
{
  imports = [ ./disk.nix ];
  network'.net.name = "server";
  services'.ssh = {
    enable = true;
    hostKey = "/etc/ssh/ssh_host_ed25519_key";
  };
  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
}
