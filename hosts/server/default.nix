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
    app.photoprism.enable = true;
    sql.mysql.enable = true;
    http.caddy = {
      enable = true;
      config = ''
        redir /photo /photo/ permanent

        route /photo/* {
          url strip_prefix /photo
          reverse_proxy localhost:2342 {
             header_up Host {http.request.host}
             header_up X-Real-IP {http.request.remote}
          }
        }
      '';
    };
  };
}
