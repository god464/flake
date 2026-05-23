{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.jujutsu = {
      # enable = true;
      settings = {
        user = {
          name = "god464";
          email = "god464@users.noreply.github.com";
        };
        signing = {
          bbehavior = "own";
          backend = "gpg";
        };
      };
    };
  };
}
