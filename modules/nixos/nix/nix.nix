{
  config,
  lib,
  pkgs,
  ...
}:
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
      package = pkgs.lix;
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
            "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
            "https://mirrors.ustc.edu.cn/nix-channels/store"
            "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
            "https://nix-community.cachix.org"
            "https://numtide.cachix.org"
            "https://cache.garnix.io"
          ]
        );
        trusted-public-keys = mkAfter (
          cfg.trustKeys
          ++ [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          ]
        );
        trusted-users = [ "@wheel" ];
        builders-use-substitutes = true;
        auto-allocate-uids = true;
        use-cgroups = true;
        use-xdg-base-directories = true;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };
    };
  };
}
