{ config, ... }:
{
  imports = [
    ../common
    ./disk.nix
  ];
  net.name = "server";
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    permitRootLogin = "yes";
  };
}
