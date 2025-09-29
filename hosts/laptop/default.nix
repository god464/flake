{ pkgs, config, ... }:
{
  imports = [ ./disk.nix ];
  boot' = {
    boot = {
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
    net.name = "laptop";
    sparkle.enable = true;
  };
  sops = {
    age.keyFile = "/var/lib/sops-nix/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      passwd.neededForUsers = true;
      host-desktop = {
        format = "binary";
        sopsFile = ./secrets/host-laptop.key;
      };
    };
  };
  nix'.home-manager.enable = true;
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    createHome = true;
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
  hardware = {
    cpu.amd.updateMicrocode = true;
    amdgpu.initrd.enable = true;
  };
  programs' = {
    fish.enable = true;
    vscode.enable = true;
    zed.enable = true;
  };
  desktop'.niri.enable = true;
  facter.reportPath = ./facter.json;
  services' = {
    gpg.enable = true;
    ssh.hostKey = config.sops.secrets.host-desktop.path;
  };
}
