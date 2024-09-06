{ pkgs, config, ... }:
{
  imports = [
    ../common
    ./desktop.nix
    ./app.nix
    ../../disko/desktop.nix
  ];
  booter.kernel = pkgs.linuxPackages_latest;
  net.name = "builder";
  nixp = {
    cache = [
      "https://cosmic.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trustKeys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    createHome = true;
    shell = pkgs.nushell;
    hashedPasswordFile = config.sops.secrets.passwd.path;
    packages = with pkgs; [
      (emacs.override { withPgtk = true; })
      just
      nushell
    ];
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ ];
    users.cl = import ./hm.nix;
  };
  virtualisation.vmware.guest.enable = true;
  fonts.packages = with pkgs; [
    fira-code
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    noto-fonts-color-emoji
  ];
  services.openssh = {
    settings.PermitRootLogin = "no";
    openFirewall = false;
  };
}
