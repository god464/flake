{ config, lib, ... }:
with lib;
let
  cfg = config.nixp;
in
{
  options.nixp = {
    enable = mkEnableOption "nixp";
    cache = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };
  config = mkIf cfg.enable {
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
        substituters = mkAfter cfg.cache;
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
      hostPlatform = "x86_64-linux";
    };
  };
}
