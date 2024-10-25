{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ../common
    ./disk.nix
  ];
  booter.kernel = pkgs.linuxPackages_latest;
  net.name = "desktop";
  sec.useAge = true;
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  nixp = {
    cache = [ "https://cosmic.cachix.org" ];
    trustKeys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    applyUdevRules = true;
  };
  hardware.enableAllFirmware = true;
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    createHome = true;
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.passwd.path;
    packages = with pkgs; [
      just
      mihomo-party
    ];
  };
  programs = {
    fish.enable = true;
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      defaultEditor = true;
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cl = import ./hm.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
  security.wrappers.mihomo-party = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_bind_service,cap_net_admin=+ep";
    source = "${lib.getExe pkgs.mihomo-party}";
  };
  fonts.packages = with pkgs; [
    fira-code
    sarasa-gothic
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-han-sans
    source-han-serif
    source-han-mono
    noto-fonts
    source-sans
    source-serif
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    twemoji-color-font
    noto-fonts-color-emoji
  ];
  desktop.cosmic.enable = true;
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/lib"
      "/var/cache"
    ];
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
      ".thunderbird"
      ".mozilla"
      ".local/share/nvim"
      ".local/share/fish"
      ".local/share/zoxide"
      ".local/state/nvim"
      ".local/state/keyrings"
      ".local/state/wireplumber"
      ".local/state/cosmic-comp"
      ".local/state/cosmic"
      ".local/state/pop-launcher"
      ".cache/nvim"
      ".cache/bat"
      ".config/cosmic"
      ".config/fcitx5"
      ".config/mihomo-party"
    ];
  };
}
