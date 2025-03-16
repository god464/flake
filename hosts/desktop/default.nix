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
    dae.enable = true;
  };
  sops = {
    age.keyFile = "/var/lib/sops-nix/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      passwd.neededForUsers = true;
      host-desktop = {
        format = "binary";
        sopsFile = ./secrets/host-desktop.key;
      };
    };
  };
  nix'.home-manager.enable = true;
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    createHome = true;
    packages = with pkgs; [ vlc ];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    amdgpu.initrd.enable = true;
  };
  programs'.fish.enable = true;
  desktop'.kde.enable = true;
  facter.reportPath = ./facter.json;
  services' = {
    gpg.enable = true;
    ssh.hostKey = config.sops.secrets.host-desktop.path;
  };
}
