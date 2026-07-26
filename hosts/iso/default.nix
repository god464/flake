{ pkgs, ... }:
{
  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  fileSystems."/" = {
    device = "/dev/root";
    fsType = "tmpfs";
  };
  boot = {
    loader.limine = {
      enable = true;
      efiSupport = true;
      biosSupport = true;
    };
    initrd.allowMissingModules = true;
    supportedFilesystems = [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
  networking = {
    hostName = "livecd";
    wireless.iwd.enable = true;
  };
  programs.fish.enable = true;
  programs.git.enable = true;
  users.users.nixos = {
    isNormalUser = true;
    initialHashedPassword = "";
    shell = pkgs.fish;
  };
  security = {
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };
  nix.settings.trusted-users = [ "nixos" ];
  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
  };
  services = {
    btrfs.autoScrub.enable = false;
    getty.autologinUser = "nixos";
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "yes";
      };
    };
  };
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_US.UTF-8";
}
