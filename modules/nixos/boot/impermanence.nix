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
        "go"
        ".cargo"
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
        ".config/fcitx5"
        ".config/DankMaterialShell"
        ".local/state/DankMaterialShell"
        ".local/state/wireplumber"
        ".mozilla"
        ".thunderbird"
        ".config/github-copilot"
        ".gemini"
        ".qwen"
        ".config/JetBrains"
        ".cache/JetBrains"
        ".local/share/JetBrains"
        ".local/share/clash-verge"
        ".local/share/io.github.clash-verge-rev.clash-verge-rev"
        ".config/io.github.clash-verge-rev.clash-verge-rev"
      ];
    };
  };
}
