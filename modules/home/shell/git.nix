{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings.user = {
        name = "god464";
        email = "god464@users.noreply.github.com";
      };
      signing = {
        key = "089E15607145FE932C002942D7A72706FC8DE569";
        signByDefault = true;
      };
    };
  };
}
