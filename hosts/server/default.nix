{ config, ... }:
{
  imports = [ ./disk.nix ];
  network'.net.name = "server";
  services'.ssh.enable = true;
  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      passwd.neededForUsers = true;
      searxng = { };
    };
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  web'.app.searxng.enable = true;
}
