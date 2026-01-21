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
    persist.enable = true;
  };
  network' = {
    net.name = "laptop";
    clash.enable = true;
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
    tmux.enable = true;
  };
  desktop'.niri.enable = true;
  facter.reportPath = ./facter.json;
  environment.systemPackages =
    let
      pkg = with pkgs.jetbrains; [
        clion
        webstorm
        goland
      ];
      mkVmOpts =
        pkg:
        pkg.override {
          forceWayland = true;
          vmopts = ''
            -Xms2048m
            -Xmx4096m
            -XX:ReservedCodeCacheSize=1024m
            -XX:+UseZGC
            -XX:+ZGenerational
            --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
            --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
            -javaagent:/home/cl/persist/ja-netfilter/ja-netfilter.jar=jetbrains
          '';

        };
    in
    map mkVmOpts pkg;
  services' = {
    gpg.enable = true;
    ssh.hostKey = config.sops.secrets.host-desktop.path;
  };
}
