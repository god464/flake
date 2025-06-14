{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        label = [
          {
            monitor = "";
            text = "$TIME12";
            position = "0, 300";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:60000] date +"%A, %B %d"'';
            position = "0, 240";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
