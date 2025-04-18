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
      users.cl.directories = [
        {
          directory = "persist";
          mode = "700";
        }
        {
          directory = ".gnupg";
          mode = "700";
        }
        {
          directory = ".ssh";
          mode = "700";
        }
        ".cache/nvim"
        ".cache/pre-commit"
        ".cache/treefmt"
        ".cache/bat"
        ".cache/nix"
        ".cache/pop-launcher"
        ".local/share/atuin"
        ".local/share/direnv"
        ".local/share/fish"
        ".local/share/nvim"
        ".local/share/zoxide"
        ".local/share/nix"
        ".local/state/nix"
        ".local/state/cosmic"
        ".local/state/cosmic-comp"
        ".local/state/pop-launcher"
        ".config/fcitx5"
        ".config/cosmic"
        ".local/state/wireplumber"
        ".mozilla"
        ".thunderbird"
      ];
    };
  };
}
