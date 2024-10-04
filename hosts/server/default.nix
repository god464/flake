{ config, ... }:
{
  imports = [
    ../common
    ./disk.nix
  ];
  net.name = "server";
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
}
