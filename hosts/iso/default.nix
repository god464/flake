{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  fileSystems."/" = {
    device = "/dev/root";
    fsType = "tmpfs";
  };
  boot.loader.grub.device = "nodev";
  networking.hostName = "livecd";
  programs.fish.enable = true;
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
