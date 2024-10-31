{ inputs, pkgs, ... }:
{
  imports = [
    ../common
    ./disk.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  boot' = {
    boot.kernel = pkgs.linuxPackages_latest;
    secure-boot.enable = true;
    impermanence.enable = true;
  };
  network' = {
    net.name = "desktop";
    mihomo.enable = true;
  };
  sec.useAge = true;
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  nix'.nix = {
    cache = [ "https://cosmic.cachix.org" ];
    trustKeys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };
  hardware.enableAllFirmware = true;
  programs = {
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
    users.cl = import ./hm.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
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
}
