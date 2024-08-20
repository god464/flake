{ config, ... }:
{
  imports = [
    ../common
    ../../disko/desktop.nix
  ];
  net.name = "router";
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
  };
}
