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
    tmux.enable = true;
  };
  desktop'.niri.enable = true;
  facter.reportPath = ./facter.json;
  environment.systemPackages = with pkgs.jetbrains; [
    (clion.override {
      forceWayland = true;
      vmopts = ''
        -Xms128m
        -Xmx1024m
        -XX:ReservedCodeCacheSize=512m
        -XX:+IgnoreUnrecognizedVMOptions
        -XX:+UseG1GC
        -XX:SoftRefLRUPolicyMSPerMB=50
        -XX:CICompilerCount=2
        -XX:+HeapDumpOnOutOfMemoryError
        -XX:-OmitStackTraceInFastThrow
        -ea
        -Dsun.io.useCanonCaches=false
        -Djdk.http.auth.tunneling.disabledSchemes=""
        -Djdk.attach.allowAttachSelf=true
        -Djdk.module.illegalAccess.silent=true
        -Dkotlinx.coroutines.debug=off
        -XX:ErrorFile=$USER_HOME/java_error_in_idea_%p.log
        -XX:HeapDumpPath=$USER_HOME/java_error_in_idea.hprof
        --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
        --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
        -javaagent:/home/cl/persist/ja-netfilter/ja-netfilter.jar=jetbrains
      '';
    })
    (goland.override {
      forceWayland = true;
      vmopts = ''
        -Xms128m
        -Xmx1024m
        -XX:ReservedCodeCacheSize=512m
        -XX:+IgnoreUnrecognizedVMOptions
        -XX:+UseG1GC
        -XX:SoftRefLRUPolicyMSPerMB=50
        -XX:CICompilerCount=2
        -XX:+HeapDumpOnOutOfMemoryError
        -XX:-OmitStackTraceInFastThrow
        -ea
        -Dsun.io.useCanonCaches=false
        -Djdk.http.auth.tunneling.disabledSchemes=""
        -Djdk.attach.allowAttachSelf=true
        -Djdk.module.illegalAccess.silent=true
        -Dkotlinx.coroutines.debug=off
        -XX:ErrorFile=$USER_HOME/java_error_in_idea_%p.log
        -XX:HeapDumpPath=$USER_HOME/java_error_in_idea.hprof
        --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
        --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
        -javaagent:/home/cl/persist/ja-netfilter/ja-netfilter.jar=jetbrains
      '';
    })
    webstorm
  ];
  services' = {
    gpg.enable = true;
    ssh.hostKey = config.sops.secrets.host-desktop.path;
  };
}
