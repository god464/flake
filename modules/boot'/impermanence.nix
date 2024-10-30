{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.boot'.impermanence;
in
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  options.boot'.impermanence.enable = mkEnableOption "impermanence";
  config = mkIf cfg.enable {
    boot.tmp.useTmpfs = true;
    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/lib"
        "/var/cache"
        "/var/log"
      ];
      files = [ "/etc/machine-id" ];
      users.cl.directories = [
        {
          directory = ".ssh";
          mode = "700";
        }
        {
          directory = ".gnupg";
          mode = "700";
        }
        "flake"
        ".cache/nix"
        ".cache/pre-commit"
        ".cache/treefmt"
        ".local/share/direnv"
        ".local/share/nix"
        ".local/state/nix"
      ];
    };
  };
}
