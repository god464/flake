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
        ];
        substituters = mkAfter (
          cfg.cache
          ++ [
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
  };
}
