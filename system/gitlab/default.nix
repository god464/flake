{ pkgs, ... }: {
  services = {
    gitlab = {
      enable = true;
      # pages.enable = true;
      # registry.enable = true;
      initialRootPasswordFile = pkgs.writeText "rootPassword" "test123";
      secrets = {
        secretFile = pkgs.writeText "secret" "Aig5zaic";
        otpFile = pkgs.writeText "otpsecret" "Riew9mue";
        dbFile = pkgs.writeText "dbsecret" "we2quaeZ";
        jwsFile = pkgs.runCommand "oidcKeyBase" { }
          "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
      };
    };
    gitlab-runner = {
      enable = true;
      clear-docker-cache.enable = true;
    };
  };
}
