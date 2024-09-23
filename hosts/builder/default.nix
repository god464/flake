{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../common
    ../../disko/desktop.nix
  ];
  booter.kernel = pkgs.linuxPackages_latest;
  net.name = "builder";
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
}
