{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.boot'.persist;
in
{
  imports = [ inputs.preservation.nixosModules.default ];
  options.boot'.persist.enable = mkEnableOption "persist";
  config = mkIf cfg.enable {
    boot.tmp.useTmpfs = true;
    preservation = {
      enable = true;
      preserveAt."/persist" = {
        directories = [
          "/var/lib"
          "/var/cache"
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
          ".cargo"
          ".cache/nvim"
          ".cache/pre-commit"
          ".cache/treefmt"
          ".cache/bat"
          ".cache/nix"
          ".cache/noctalia"
          ".local/share/atuin"
          ".local/share/fish"
          ".local/share/nvim"
          ".local/share/direnv"
          ".local/share/zoxide"
          ".local/share/nix"
          ".local/state/nix"
          ".local/state/nvim"
          ".config/fcitx5"
          ".config/noctalia/"
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
          ".local/share/zathura"
        ];
      };
    };
  };
}
