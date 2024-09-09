{
  config,
  lib,
  inputs,
  ...
}:
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
      nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      settings = {
        auto-optimise-store = true;
        pure-eval = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "repl-flake"
        ];
        substituters = mkAfter (
          cfg.cache
          ++ [
            "https://mirrors.bfsu.edu.cn/nix-channels/store"
            "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
            "https://mirrors.ustc.edu.cn/nix-channels/store"
            "https://cache.nixos.org"
            "https://nix-community.cachix.org"
          ]
        );
        trusted-public-keys = mkAfter (
          cfg.trustKeys ++ [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ]
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
        warnUndeclaredOptions = true;
      };
      hostPlatform = cfg.platform;
    };
    system.stateVersion = "24.05";
  };
}
