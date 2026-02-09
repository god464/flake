{ pkgs, ... }:
{
  network'.net.name = "livecd";
  programs'.fish.enable = true;
  boot.initrd = {
    systemd.enable = false;
    allowMissingModules = true;
  };
  programs.git.enable = true;
  users.users = {
    nixos = {
      isNormalUser = true;
      initialHashedPassword = "";
      shell = pkgs.fish;
    };
    root = {
      initialHashedPassword = "";
      shell = pkgs.fish;
    };
  };
  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "nixos" ];
  services.getty.autologinUser = "nixos";
  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
  };
  services.btrfs.autoScrub.enable = false;
}
