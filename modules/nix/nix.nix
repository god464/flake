{ config, lib, ... }:
let
  cfg = config.nix'.nix;
  inherit (lib) types mkOption mkAfter;
in
{
  options.nix'.nix = {
    cache = mkOption {
      default = [ ];
      type = types.listOf types.str;
    };
    trustKeys = mkOption {
      default = [ ];
      type = types.listOf types.str;
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
          "pipe-operators"
        ];
        substituters = mkAfter (
          cfg.cache
          ++ [
            "https://mirror.sjtu.edu.cn/nix-channels/store"
            "https://nix-community.cachix.org"
            "https://cache.garnix.io"
            "https://cache.nixos.org"
          ]
        );
        trusted-public-keys = mkAfter (
          cfg.trustKeys
          ++ [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
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
  };
}
