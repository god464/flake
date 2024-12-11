{ config, ... }:
{
  imports = [ ./disk.nix ];
  network'.net.name = "server";
  services'.ssh.enable = true;
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  web'.app.forgejo.enable = true;
}
