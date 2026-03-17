{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    types
    mkOption
    mkDefault
    mkIf
    ;
  hasDisplay = config.services.displayManager.enable;
  mkListOfStr = mkOption {
    type = types.listOf types.str;
    default = [ ];
  };
  cfg = config.boot'.boot;
in
{
  options.boot'.boot = {
    para = mkListOfStr;
    availableKernelModules = mkListOfStr;
    supportedFilesystems = mkListOfStr;
    kernelModules = mkListOfStr;
  };
  config = {
    boot = {
      initrd = {
        inherit (cfg) supportedFilesystems availableKernelModules;
        systemd.enable = true;
      };
      inherit (cfg) kernelModules;
      enableContainers = false;
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        efi.canTouchEfiVariables = true;
        limine = mkIf hasDisplay {
          enable = true;
          secureBoot.enable = true;
        };
        systemd-boot = mkIf (!hasDisplay) {
          enable = true;
          editor = false;
        };
      };
      tmp.useTmpfs = true;
      plymouth.enable = hasDisplay;
      consoleLogLevel = mkIf hasDisplay 0;
      kernelParams = mkIf hasDisplay (
        cfg.para
        ++ [
          "quiet"
          "splash"
        ]
      );
    };
    zramSwap.enable = true;
    services.btrfs.autoScrub.enable = mkDefault true;
  };
}
