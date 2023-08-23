{ pkgs, lib, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../system/coreServer.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
        netbootxyz.enable = true;
        memtest86.enable = true;
      };
    };
    supportedFilesystems = [
      "btrfs"
      "ntfs"
      "exfat"
    ];
  };
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      enableStrongSwan = true;
      enableFccUnlock = true;
    };
  };

  users.users.cl = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    createHome = true;
    shell = pkgs.zsh;
    initialPassword = "a";
  };

  environment = {
    systemPackages = lib.mkAfter (with pkgs; [
      ninja
      meson
      lldb
      clang
      luajit
      jdk
      python3
      texlive.combined.scheme-full
      sbctl
      unzip
      unrar
    ]);
  };
  # Services
  services = {
    resolved.enable = true;
    # OpenSSH
    openssh.enable = true;

    # Btrfs
    btrfs.autoScrub.enable = true;
  };

  # Virtualisation
  virtualisation = {
    # Docker
    docker.enable = true;
    #vmware
    vmware.guest.enable = true;
  };

}
