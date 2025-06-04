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
      photoprism = { };
    };
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.passwd.path;
  web' = {
    http.nginx.enable = true;
    app.grafana.enable = true;
  };
  monitor'.prometheus.enable = true;
}
