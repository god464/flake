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
        ".local/share/atuin"
        ".local/share/fish"
        ".local/share/nvim"
        ".local/share/direnv"
        ".local/share/zoxide"
        ".local/share/nix"
        ".local/state/nix"
        ".local/state/nvim"
        ".local/share/CMakeTools"
        ".config/fcitx5"
        ".config/sparkle"
        ".config/zed"
        ".local/share/zed"
        ".local/state/wireplumber"
        ".mozilla"
        ".thunderbird"
        ".codeium"
        ".gemini"
        ".qwen"
        ".vscode"
        ".config/Code"
      ];
    };
  };
}
