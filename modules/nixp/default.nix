{ config, lib, ... }:
let
  cfg = config.nixp;
  inherit (lib) types mkOption mkAfter;
in
{
  options.nixp = {
    cache = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    trustKeys = mkOption {
      type = types.listOf types.str;
      default = [ ];
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
        pure-eval = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = mkAfter (cfg.cache ++ [ "https://cache.nixos.org" ]);
        trusted-public-keys = mkAfter cfg.trustKeys;
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
        warnUndeclaredOptions = true;
      };
      hostPlatform = cfg.platform;
    };
    system.stateVersion = "24.05";
  };
}
