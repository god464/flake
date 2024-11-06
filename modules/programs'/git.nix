{ config, lib, ... }:
let
  cfg = config.programs'.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    home-manager.users.cl.programs.git = {
      enable = true;
      delta.enable = true;
      userName = "god464";
      userEmail = "god464@users.noreply.github.com";
      signing = {
        key = "089E15607145FE932C002942D7A72706FC8DE569";
        signByDefault = true;
      };
    };
  };
}
