{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.gh = {
      enable = true;
      settings = {
        editor = "nvim";
        protocol = "ssh";
      };
    };
  };
}
