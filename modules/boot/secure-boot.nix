{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.sops) secrets;
  cfg = config.boot'.secure-boot;
in
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  options.boot'.secure-boot.enable = mkEnableOption "secure-boot";
  config = mkIf cfg.enable {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        publicKeyFile = secrets.db-pem.path;
        privateKeyFile = secrets.db-key.path;
      };
    };
  };
}
