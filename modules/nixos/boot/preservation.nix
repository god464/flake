{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.boot'.preservation;
in
{
  imports = [ inputs.preservation.nixosModules.preservation ];
  options.boot'.preservation.enable = mkEnableOption "preservation";
  config = mkIf cfg.enable {
    boot.tmp.useTmpfs = true;
    preservation.preserveAt."/persist" = {
      enable = true;
      directories = [
        "/var/lib"
        "/var/cache"
        "/var/log"
      ];
      users.cl.directories = [
        {
          directory = "persist";
          mode = "0700";
        }
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".cache/nvim"
        ".cache/pre-commit"
        ".cache/treefmt"
        ".cache/bat"
        ".cache/nix"
        ".local/share/atuin"
        ".local/share/direnv"
        ".local/share/fish"
        ".local/share/nvim"
        ".local/share/zoxide"
        ".local/share/nix"
        ".local/state/nix"
        ".config/fcitx5"
        ".config/cosmic"
        ".local/state/wireplumber"
        ".mozilla"
        ".thunderbird"
      ];
    };
  };
}
