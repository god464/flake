{
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
      ".config/cosmic"
      ".config/mihomo-party"
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
      ".local/state/cosmic-comp"
      ".local/state/cosmic"
      ".local/state/pop-launcher"
      ".config/fcitx5"
      ".local/state/wireplumber"
      ".mozilla"
      ".thunderbird"
      ".supermaven"
    ];
  };
}
