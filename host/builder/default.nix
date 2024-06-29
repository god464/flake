{ pkgs, config, ... }: {
  imports = [ ../common ./desktop.nix ./app.nix ];
  boot = import ./boot.nix;
  networking = import ./network.nix;
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    createHome = true;
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.passwd.path;
    packages = with pkgs; [
      emacs29-pgtk
      shfmt
      nixfmt
      nil
      just
      shellcheck
      python3
      yaml-language-server
      gcc
      cmake
      gnumake
    ];
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ ];
    users.cl = import ./hm.nix;
  };
  virtualisation.vmware.guest.enable = true;
}
