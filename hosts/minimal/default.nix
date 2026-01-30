{
  imports = [ ./disk.nix ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
  networking = {
    hostName = "minimal";
    nftables.enable = true;
    firewall = {
      checkReversePath = "strict";
      filterForward = true;
    };
    useNetworkd = true;
    enableIPv6 = true;
  };
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = true;
      DNSSEC = true;
    };
  };
  users.users.root.initialPassword = "a";
  nix = {
    channel.enable = false;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      trusted-users = [ "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };
  system.stateVersion = "26.05";
  nixpkgs.hostPlatform.system = "aarch64-linux";
}
