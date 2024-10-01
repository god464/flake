{ config, ... }:
{
  imports = [
    ../common
    ./disk.nix
  ];
  net.name = "server";
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  services = {
    openssh = {
      enable = true;
      startWhenNeeded = true;
      settings.PermitRootLogin = "yes";
    };
    fail2ban = {
      enable = true;
      bantime-increment.enable = true;
    };
  };
}
