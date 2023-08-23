{
  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowPing = true;
  };
  # users = {
  #   groups.httpd = { };
  #   users.httpd = {
  #     isSystemUser = true;
  #     group = "httpd";
  #   };
  # };
  services.httpd = {
    enable = true;
    enableMellon = true;
    enablePHP = true;
    # enablePerl = true;
    # user = "httpd";
    # group = "httpd";
    virtualHosts = {
      localhost = {
        hostName = "localhost";
        adminAddr = "a@a.com";
        enableUserDir = true;
        documentRoot = "/var/www/localhost";
        serverAliases = [ "localhost" ];
        locations = {
          # "/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
          "/phpmyadmin" = { index = "index.php"; };
        };
      };
    };
  };
}
