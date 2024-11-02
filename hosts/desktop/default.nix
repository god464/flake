{ pkgs, config, ... }:
{
  imports = [ ./disk.nix ];
  boot' = {
    boot.kernel = pkgs.linuxPackages_latest;
    secure-boot.enable = true;
    impermanence.enable = true;
  };
  network' = {
    net.name = "desktop";
    mihomo.enable = true;
  };
  sops = {
    age.keyFile = "/var/lib/sops-nix/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  nix' = {
    nix = {
      cache = [ "https://cosmic.cachix.org" ];
      trustKeys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
    };
    home-manager.enable = true;
  };
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    createHome = true;
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.passwd.path;
    packages = with pkgs; [ just ];
  };
  hardware.enableAllFirmware = true;
  programs' = {
    fish.enable = true;
  };
  services' = {
    ssh.enable = true;
    gpg.enable = true;
  };
  fonts.packages = with pkgs; [
    fira-code
    sarasa-gothic
    fira-sans
    fira-mono
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
}
