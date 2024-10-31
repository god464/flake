{ config, ... }:
{
  imports = [
    ../common
    ./disk.nix
  ];
  network'.net.name = "server";
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
}
