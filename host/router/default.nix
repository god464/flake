{ config, ... }:
{
  imports = [
    ../common
    ./proxy.nix
    ./ssh.nix
  ];
  net.name = "router";
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  sops.secrets.wgkey = {
    owner = config.users.users."systemd-network".name;
    mode = "400";
  };
}
