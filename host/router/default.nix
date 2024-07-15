{ config, ... }:
{
  imports = [
    ../common
    ./network.nix
    ./proxy.nix
    ./ssh.nix
  ];
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  sops.secrets.wgkey = {
    owner = config.users.users."systemd-network".name;
    mode = "400";
  };
}
