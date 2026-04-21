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
      kernelModules = [ "kvm-amd" ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "uas"
        "usbhid"
        "sd_mod"
      ];
      supportedFilesystems = [ "ntfs" ];
    };
    persist.enable = true;
  };
  network' = {
    net.name = "laptop";
    clash.enable = true;
  };
  sops = {
    age.keyFile = "/var/lib/secrets/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets.passwd.neededForUsers = true;
  };
  nix'.home-manager.enable = true;
  users.users.cl = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    createHome = true;
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.passwd.path;
  };
  hardware = {
    cpu.amd.updateMicrocode = true;
    facter.reportPath = ./facter.json;
  };
  programs' = {
    fish.enable = true;
    tmux.enable = true;
    zen.enable = true;
    vscode.enable = true;
    chromium.enable = true;
  };
  desktop'.niri.enable = true;
  environment = {
    systemPackages =
      let
        pkg = [ ];
        mkVmOpts =
          pkg:
          pkg.override {
            forceWayland = true;
            vmopts = ''
              -Xms2048m
              -Xmx8192m
              -XX:NewSize=512m
              -XX:MaxNewSize=2048m
              -XX:MetaspaceSize=512m
              -XX:MaxMetaspaceSize=1024m
              -XX:+UseZGC
              -XX:SoftRefLRUPolicyMSPerMB=50
              -XX:+ZGenerational
              -XX:+DisableExplicitGC
              -XX:+OptimizeStringConcat
              -XX:ReservedCodeCacheSize=1024m
              -XX:+UseCompressedOops
              --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
              --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
              -javaagent:/home/cl/persist/ja-netfilter/ja-netfilter.jar=jetbrains
            '';
          };
      in
      map mkVmOpts pkg;
    etc."machine-id" = {
      text = "12d844a4fc17460abb59c9e077267d82";
      mode = "0444";
    };
  };
  services' = {
    gpg.enable = true;
    ssh.hostKey = "/var/lib/ssh/ssh_host_ed25519_key";
  };
}
