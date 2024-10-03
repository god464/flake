{
  config,
  lib,
  ...
}:
let
  cfg = config.nixp;
  inherit (lib) types mkOption mkAfter;
in
{
  options.nixp = {
    cache = mkOption {
      default = [ ];
      type = types.listOf types.str;
    };
    trustKeys = mkOption {
      default = [ ];
      type = types.listOf types.str;
    };
    platform = mkOption {
      type = types.str;
      default = "x86_64-linux";
    };
  };
  config = {
    nix = {
      sshServe.enable = true;
      channel.enable = false;
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "auto-allocate-uids"
          "ca-derivations"
          "cgroups"
          "nix-command"
          "flakes"
          "repl-flake"
        ];
        substituters = mkAfter (
          cfg.cache
          ++ [
            "https://mirrors.bfsu.edu.cn/nix-channels/store"
            "https://mirror.sjtu.edu.cn/nix-channels/store"
            "https://mirrors.ustc.edu.cn/nix-channels/store"
            "https://cache.nixos.org"
            "https://nix-community.cachix.org"
            "https://cache.garnix.io"
          ]
        );
        trusted-public-keys = mkAfter (
          cfg.trustKeys
          ++ [
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ]
        );
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };
    };
    nixpkgs = {
      config = {
        allowUnfree = true;
        checkMeta = true;
        warnUndeclaredOptions = true;
      };
      hostPlatform = cfg.platform;
    };
    system.stateVersion = "24.05";
  };
}
