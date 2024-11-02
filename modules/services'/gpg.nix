{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.services'.gpg;
in
{
  options.services'.gpg.enable = mkEnableOption "gpg";
  config = mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
    home-manager.users.cl.programs.gpg.enable = true;
    environment.persistence."/persist".users.cl.directories = [
      {
        directory = ".gnupg";
        mode = "700";
      }
    ];
  };
}
