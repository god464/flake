{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      delta = {
        enable = true;
        options = {
          dark = true;
          line-numbers = true;
        };
      };
      userName = "god464";
      userEmail = "god464@users.noreply.github.com";
      signing = {
        key = "089E15607145FE932C002942D7A72706FC8DE569";
        signByDefault = true;
      };
    };
  };
}
