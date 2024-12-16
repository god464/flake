{ pkgs, config, ... }:
{
  imports = [ ./disk.nix ];
  boot' = {
    boot = {
      kernel = pkgs.linuxPackages_latest;
      para = [
        "amd_pstate=active"
        "radeon.cik_support=0"
        "amdgpu.cik_support=1"
      ];
    };
    secure-boot.enable = true;
    impermanence.enable = true;
  };
  network' = {
    net.name = "desktop";
    clash.enable = true;
  };
  sops = {
    age.keyFile = "/var/lib/sops-nix/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  nix'.home-manager.enable = true;
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    createHome = true;
    packages = with pkgs; [ gh ];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    amdgpu.initrd.enable = true;
  };
  programs'.fish.enable = true;
  services' = {
    ssh.enable = true;
    gpg.enable = true;
  };
  desktop'.kde.enable = true;
}
