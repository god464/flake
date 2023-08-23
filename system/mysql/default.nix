{ pkgs, ... }: {
  networking.firewall = {
    allowedTCPPorts = [ 3306 ];
    allowPing = true;
  };
  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
      dataDir = "/var/lib/mysql";
      replication = {
        slaveHost = "127.0.0.1";
        masterUser = "cl";
        masterPassword = "a";
      };
      ensureUsers = [{
        name = "cl";
        ensurePermissions = { "*.*" = "ALL PRIVILEGES"; };
      }];
      initialDatabases = [{
        name = "course";
        schema = /home/cl/course.sql;
      }];
    };
    mysqlBackup = { enable = true; };
  };
}
