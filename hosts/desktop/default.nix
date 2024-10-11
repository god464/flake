{
  inputs,
  pkgs,
  config,
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
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    createHome = true;
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.passwd.path;
    packages = with pkgs; [ just ];
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
  virtualisation.vmware.guest.enable = true;
  fonts.packages = with pkgs; [
    fira-code
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    noto-fonts-color-emoji
  ];
  desktop.cosmic.enable = true;
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/ssh"
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
      ".local/share/nvim"
      ".local/share/fish"
      ".local/share/zoxide"
      ".local/state/nvim"
      ".local/state/cosmic-comp"
      ".cache/nvim"
      ".cache/bat"
      ".config/cosmic"
      ".config/fcitx5"
    ];
  };
}
