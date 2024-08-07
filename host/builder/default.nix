{ pkgs, config, ... }:
{
  imports = [
    ../common
    ./desktop.nix
    ./app.nix
  ];
  net.name = "builder";
  nixp = {
    cache = [ "https://cosmic.cachix.org/" ];
    trustKeys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    createHome = true;
    shell = pkgs.nushell;
    hashedPasswordFile = config.sops.secrets.passwd.path;
    packages = with pkgs; [
      (emacs.override { withPgtk = true; })
      shfmt
      nixfmt-rfc-style
      nixd
      just
      shellcheck
      python3
      yaml-language-server
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
}
